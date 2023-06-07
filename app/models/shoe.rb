class Shoe < ApplicationRecord

  has_one_attached :shoe_image

  belongs_to :customer
  has_many   :keeps,          dependent: :destroy
  has_many   :shoe_comments,  dependent: :destroy
  has_many   :shoe_tags,      dependent: :destroy
  has_many   :tags,           through: :shoe_tags

  def get_shoe_image(width, height)
    unless shoe_image.attached?
      file_path = Rails.root.join('app/assets/images/no_shoes_image.jpg')
      shoe_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    shoe_image.variant(resize_to_limit: [width, height]).processed
  end

  def keeped_by?(customer)
    keeps.exists?(customer_id: customer.id)
  end

  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    # 現在のタグリスト内で、sent_tagsには含まれていないタグを削除
    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name: old)
    end

    # 現在のタグリスト内にない、sent_tagsに含まれる新しいタグを追加
    new_tags.each do |new|
      new_shoe_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_shoe_tag
    end
  end

end
