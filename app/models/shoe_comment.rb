class ShoeComment < ApplicationRecord

  belongs_to :customer
  belongs_to :shoe

  validates :shoe_comment,  presence: true

end
