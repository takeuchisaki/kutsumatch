class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one_attached :profile_image
  
  has_many :shoes,                    dependent: :destroy
  has_many :keeps,                    dependent: :destroy
  has_many :shoes_comments,           dependent: :destroy
  has_many :relationships,            class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings,               through: :relationships,            source: :followed
  has_many :followers,                through: :reverse_of_relationships, source: :follower
  
end
