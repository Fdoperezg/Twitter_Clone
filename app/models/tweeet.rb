class Tweeet < ApplicationRecord
  belongs_to :user, class_name: "User", foreign_key: "user_id"  
  validates :tweeet, presence: true, length: { maximum: 140 }
  has_many :likes, dependent: :destroy
  has_many :linking_users, :through => :likes, :source => :user
  paginates_per 5
  has_many :tweeets
  belongs_to :tweeets, optional: true
  validates :tweeet_id, uniqueness: {scope: :user_id }, allow_nil: true
    
  scope :tweets_for_me, ->(users_list) { where(
      user_id: users_list.map do |friendships|
          friend.friend
      end
  ) }

  scope :created_between, ->(start_date, end_date) {where(
      "(created_at) >= ? AND (created_at) <= ?", start_date, end_date
  ) }

  def origin
    @origin = Tweeet.find(self.tweeet_id)
  end

  def count_retweet
    Tweeet.where(tweeet_id: self.id).count
  end
end