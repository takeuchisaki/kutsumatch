class Shoe < ApplicationRecord
  
  has_one_attached :shoes_image
  
  belongs_to :customer
  belongs_to :genre
  has_many   :keeps,           dependent: :destroy
  has_many   :shoes_comments,  dependent: :destroy
  
end
