class ShoesComment < ApplicationRecord
  
  belongs_to :customer
  belongs_to :shoe
  
end
