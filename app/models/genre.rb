class Genre < ApplicationRecord
  
  has_many :shoes, dependent: :destroy
  
end
