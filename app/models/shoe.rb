class Shoe < ApplicationRecord

  has_one_attached :shoe_image

  belongs_to :customer
  belongs_to :genre
  has_many   :keeps,          dependent: :destroy
  has_many   :shoe_comments,  dependent: :destroy

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

end
