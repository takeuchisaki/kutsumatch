class Shoe < ApplicationRecord
  
  has_one_attached :shoes_image
  
  belongs_to :customer
  belongs_to :genre
  has_many   :keeps,           dependent: :destroy
  has_many   :shoe_comments,  dependent: :destroy
  
  def get_shoes_image(width, height)
    unless shoes_image.attached?
      file_path = Rails.root.join('app/assets/images/no_shoes_image.jpg')
      shoes_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    shoes_image.variant(resize_to_limit: [width, height]).processed
  end
  
end
