class Tag < ApplicationRecord

  has_many   :shoe_tags,  dependent: :destroy
  has_many   :shoes,      through: :shoe_tags

  scope :tag_search, -> (word) {
    where("name LIKE?", "%#{word}%")
  }

end
