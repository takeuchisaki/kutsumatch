class Tag < ApplicationRecord
  
  has_many   :shoe_tags,  dependent: :destroy
  has_many   :shoes,      through: :shoe_tags
  
  def self.search(word)
    where("name LIKE?", "%#{word}%")
  end
  
end
