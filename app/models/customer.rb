class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  has_many :shoes,                    dependent: :destroy
  has_many :keeps,                    dependent: :destroy
  has_many :shoe_comments,           dependent: :destroy
  has_many :relationships,            class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings,               through: :relationships,            source: :followed
  has_many :followers,                through: :reverse_of_relationships, source: :follower


  validates :name,          presence: true,         length: { in: 2..15 }
  validates :foot_size,     numericality: { greater_than_or_equal_to: 20, less_than_or_equal_to: 35 }
  validates :introduction,  length: { maximum: 50 }


  enum foot_width: {
    no_width:   0,
    narrow:     1,
    standard:   2,
    wide:       3,
    not_clear:  4
  }

  enum foot_type: {
    no_type:      0,
    egypt_type:   1,
    greek_type:   2,
    square_type:  3
  }

  enum gender: {
    no_gender:  0,
    man:        1,
    woman:      2,
  }


  # ゲストユーザーについて
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "ゲスト"
      customer.foot_size = "20"
    end
  end

  def guest_customer?
    email == GUEST_USER_EMAIL
  end

  # ユーザーの画像について
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join("app/assets/images/no_profile_image.jpg")
      profile_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

# 検索・素掘り込みについて
  # ワードによる検索条件
  scope :customer_search, -> (word) {
    where("customer.name LIKE ? OR foot_size LIKE ? OR foot_width LIKE ? OR foot_type LIKE ?", "%#{word}%", "%#{word}%", "%#{word}%", "%#{word}%")
  }

  # 足のサイズによる絞り込み条件
  scope :search_by_foot_size, -> (foot_size){
    where("foot_size LIKE ?", "%#{foot_size}%")
  }

  # 絞り込み結果をもとにしたユーザー
  scope :search_by_customer_filters, -> (params) {
    customers = all
    # 足サイズによる絞り込み
    if params[:foot_size].present?
      customers = customers.search_by_foot_size(params[:foot_size])
    end
    # 足幅による絞り込み
    if params[:foot_width].present?
      customers = customers.where(foot_width: params[:foot_width])
    end
    # 足タイプによる絞り込み
    if params[:foot_type].present?
      customers = customers.where(foot_type: params[:foot_type])
    end
    # 性別による絞り込み
    if params[:gender].present?
      customers = customers.where(gender: params[:gender])
    end
    customers
  }

# フォロー・フォロワーについて
  # フォローする際
  def follow(customer)
    relationships.create(followed_id: customer.id)
  end
  # フォローを外す際
  def unfollow(customer)
    relationships.find_by(followed_id: customer.id).destroy
  end
  # フォローしているかの確認
  def following?(customer)
    followings.include?(customer)
  end

end
