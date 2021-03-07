class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweeets, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :following, foreign_key: "follower_id", class_name: "Friendship"
  has_many :followers, foreign_key: "followed_id", class_name: "Friendship"

  validates :username, presence: true, uniqueness: true 

  def following?(tweeet)
    f = Friendship.find_by(friendship_id: tweeet.user.id) 
    if f.nil?
      return false
    else
      return true
    end
  end
end
