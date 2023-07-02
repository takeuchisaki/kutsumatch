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
  # validates :match_rate,  presence: true
  
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
  def self.search(word)
    where("name LIKE ? OR body LIKE ? OR tag_name LIKE ? OR shoe_size LIKE? OR match_rate LIKE?",
          "%#{word}%", "%#{word}%", "%#{word}%", "%#{word}%", "%#{word}%")
  end

  # 靴のサイズによる絞り込み条件
  def self.search_by_shoe_size(min_shoe_size, max_shoe_size)
    if min_shoe_size.present? && max_shoe_size.present?
      where("shoe_size >= ? AND shoe_size <= ?", min_shoe_size, max_shoe_size)
    elsif min_shoe_size.present?
      where("shoe_size >= ?", min_shoe_size)
    elsif max_shoe_size.present?
      where("shoe_size <= ?", max_shoe_size)
    else
      all
    end
  end

  # マッチ度による絞り込み条件
  def self.search_by_match(min_match, max_match)
    if min_match.present? && max_match.present?
      where("match_rate >= ? AND match_rate <= ?", min_match, max_match)
    elsif min_match.present?
       where("match_rate >= ?", min_match)
    elsif max_match.present?
      where("match_rate <= ?", max_match)
    else
      all
    end
  end

  # 価格による絞り込み条件
  def self.search_by_price(min_price, max_price)
    if min_price.present? && max_price.present?
      where("price >= ? AND price <= ?", min_price, max_price)
    elsif min_price.present?
       where("price >= ?", min_price)
    elsif max_price.present?
      where("price <= ?", max_price)
    else
      all
    end
  end

  # 検索・絞り込み結果をもとにしたshoe投稿
  def self.search_by_filters(params)
    shoes = all
    # ワードによる絞り込み
    if params[:word].present?
      shoes = shoes.search(params[:word])
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
  end

end
