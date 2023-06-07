class ShoeTag < ApplicationRecord
  
  belongs_to :shoe
  belongs_to :tag
  
  validates :shoe_id, presence: true
  validates :tag_id,  presence: true
  
end
