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

  validates :name,      presence: true
  validates :foot_size, presence: true


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

  enum gender: {
    man:    0,
    woman:  1,
  }

  # ゲストユーザーについて
  def self.guest
    find_or_create_by!(name: 'guestcustomer', email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
    end
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
  def self.search(word)
    where("name LIKE ?", "%#{word}%")
  end

  # 足のサイズによる絞り込み条件
  def self.search_by_foot_size(foot_size)
    where("foot_size LIKE ?", "%#{foot_size}%")
  end

  # 絞り込み結果をもとにしたユーザー
  def self.search_by_filters(params)
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
  end

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
