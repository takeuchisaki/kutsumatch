class ShoeComment < ApplicationRecord

  belongs_to :customer
  belongs_to :shoe

  validates :comment,  presence: true

end
