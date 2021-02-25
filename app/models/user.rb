class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweeets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friends, dependent: :destroy

  validates :username, presence: true, uniqueness: true #, format: { with: /\A[a-zA-Z0-9]+\Z/ }

  def followers(user)
    Friend.where(friend_id: user.id).count
  end
end
