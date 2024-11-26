class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  

  has_many :following_relationships, class_name: "Relationship", foreign_key: 'follower_id', dependent: :destroy
  has_many :followings, through: :following_relationships, source: :following
  
  has_many :follower_relationships, class_name: "Relationship", foreign_key: 'following_id', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower


  
  
  

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def is_followed_by?(user)
    follower_relationships.find_by(following_id: user.id).present?
  end

  def follow(user_id)
    transaction do
      following_relationships.create(following_id: user_id)
    end
  end

  def unfollow(user_id)
    transaction do
      following_relationships.find_by(following_id: user_id).destroy
    end
  end
  

  def following?(user)
    followings.include?(user)
  end

end
