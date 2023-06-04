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

    enum foot_width: {
    narrow:     0,
    standard:   1,
    wide:       2,
    not_clear:  3
  }

  enum foot_type: {
    egypt_type:   0,
    greek_type:   1,
    square_type:  2
  }

  enum sex: {
    man:    0,
    woman:  1,
  }


  def self.guest
    find_or_create_by!(name: 'guestcustomer', email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
    end
  end

end
