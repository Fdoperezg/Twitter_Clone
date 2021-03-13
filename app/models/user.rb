class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweeets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :following, foreign_key: "follower_id", class_name: "Friendship"
  has_many :followers, foreign_key: "followed_id", class_name: "Friendship"
  before_create :set_api_key

  validates :username, presence: true, uniqueness: true 

  def following?(tweeet)
    f = Friendship.find_by(friendship_id: tweeet.user.id) 
    if f.nil?
      return false
    else
      return true
    end
  end

  def tweets_for_me
    friend_list = self.friendships.pluck(:friendship_id)
    tweeets_for_me = [] 
      friend_list.each do |friend_id|
        friend = User.find(friend_id)
          friend.tweeets.each do |tweeet|
            tweeets_for_me.push tweeet
          end
      end
      tweeets_for_me 
  end

  def generate_api_key
    SecureRandom.base58(24)
  end
  
  def set_api_key
    self.api_key = generate_api_key
  end 
end


