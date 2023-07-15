class Shoe < ApplicationRecord

  has_one_attached :shoe_image

  belongs_to :customer
  has_many   :keeps,          dependent: :destroy
  has_many   :shoe_comments,  dependent: :destroy
  has_many   :shoe_tags,      dependent: :destroy
  has_many   :tags,           through: :shoe_tags

  validates :name,        presence: true
  validates :body,        length: { in:1..200 }
  validates :shoe_size,   presence: true
  
  # 靴の画像について
  def get_shoe_image(width, height)
    unless shoe_image.attached?
      file_path = Rails.root.join('app/assets/images/no_shoes_image.jpg')
      shoe_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    shoe_image.variant(resize_to_limit: [width, height]).processed
  end

  # 指定された顧客によって保存されているかどうか確認
  def keeped_by?(customer)
    keeps.exists?(customer_id: customer.id)
  end

  # タグについて
  def save_tag(sent_tags)
    # 現在のタグリスト
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在のタグリスト内で、sent_tagsに含まれていないタグを特定
    old_tags = current_tags - sent_tags
    # 現在のタグリストに無い、sent_tagsに含まれる新しいタグを特定
    new_tags = sent_tags - current_tags

    #sent_tagsには含まれていないタグを削除
    old_tags.each do |old|
      self.tags.destroy Tag.find_by(name: old)
    end

    # sent_tagsに含まれる新しいタグを追加
    new_tags.each do |new|
      new_tag = Tag.find_or_create_by(name: new)
      self.tags << new_tag
    end
  end

# 検索・素掘り込みについて
  # ワードによる検索条件
  scope :shoe_search, -> (word) {
    where("shoes.name LIKE ? OR body LIKE ? OR tag_name LIKE ? OR shoe_size LIKE? OR match_rate LIKE?",
          "%#{word}%", "%#{word}%", "%#{word}%", "%#{word}%", "%#{word}%")
  }

  # 靴のサイズによる絞り込み条件
  scope :search_by_shoe_size, -> (min_shoe_size, max_shoe_size) {
    if min_shoe_size.present? && max_shoe_size.present?
      where("shoe_size >= ? AND shoe_size <= ?", min_shoe_size, max_shoe_size)
    elsif min_shoe_size.present?
      where("shoe_size >= ?", min_shoe_size)
    elsif max_shoe_size.present?
      where("shoe_size <= ?", max_shoe_size)
    else
      all
    end
  }

  # マッチ度による絞り込み条件
  scope :search_by_match, -> (min_match, max_match) {
    if min_match.present? && max_match.present?
      where("match_rate >= ? AND match_rate <= ?", min_match, max_match)
    elsif min_match.present?
       where("match_rate >= ?", min_match)
    elsif max_match.present?
      where("match_rate <= ?", max_match)
    else
      all
    end
  }

  # 価格による絞り込み条件
  scope :search_by_price, -> (min_price, max_price) {
    if min_price.present? && max_price.present?
      where("price >= ? AND price <= ?", min_price, max_price)
    elsif min_price.present?
       where("price >= ?", min_price)
    elsif max_price.present?
      where("price <= ?", max_price)
    else
      all
    end
  }

  # 検索・絞り込み結果をもとにしたshoe投稿
    scope :search_by_shoe_filters, -> (params) {
      shoes = all
      # ワードによる絞り込み
      if params[:word].present?
        shoes = shoes.shoe_search(params[:word])
      end
      # 靴のサイズによる絞り込み
      if params[:min_shoe_size].present? || params[:max_shoe_size].present?
        shoes = shoes.search_by_shoe_size(params[:min_shoe_size], params[:max_shoe_size])
      end
      # マッチ度による絞り込み
      if params[:min_match].present? || params[:max_match].present?
        shoes = shoes.search_by_match(params[:min_match], params[:max_match])
      end
      # 価格による絞り込み
      if params[:min_price].present? || params[:max_price].present?
        shoes = shoes.search_by_price(params[:min_price], params[:max_price])
      end
      shoes
    }
    
    scope :search_by_customer_filters, -> (params) {
      shoes = joins(:customer)
      # 足サイズによる絞り込み
      if params[:foot_size].present?
        shoes = shoes.merge(Customer.search_by_foot_size(params[:foot_size]))
      end
      # 足幅による絞り込み
      if params[:foot_width].present?
        shoes = shoes.merge(Customer.where(foot_width: params[:foot_width]))
      end
      # 足タイプによる絞り込み
      if params[:foot_type].present?
        shoes = shoes.merge(Customer.where(foot_type: params[:foot_type]))
      end
      # 性別による絞り込み
      if params[:gender].present?
        shoes = shoes.merge(Customer.where(gender: params[:gender]))
      end
      shoes
    }
  
  # 投稿日絞り込み
  scope :shoe_created_at_filters, -> (filter) {
    # 当日
    if filter == "Today"
      where("created_at >= ?", Date.today.beginning_of_day)
    # 3日間
    elsif filter == "ThreeDay"
      where("created_at >= ?", 3.days.ago.beginning_of_day)
    # 1週間
    elsif filter == "OneWeek"
      where("created_at >= ?", 1.week.ago.beginning_of_day)
    # 1ヶ月間
    elsif filter == "OneMonth"
      where("created_at >= ?", 1.month.ago.beginning_of_day)
    # 1年間
    elsif filter == "OneYear"
      where("created_at >= ?", 1.year.ago.beginning_of_day)
    else
      all
    end
  }

end
