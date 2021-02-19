class Tweeet < ApplicationRecord
    validates :tweeet, presence: true, length: { maximum: 140 }
    belongs_to :user, class_name: "User", foreign_key: "user_id"
    has_many :likes, dependent: :destroy
    paginates_per 10

    def retweets
        retweet_count = Tweeet.group(:tweeet_id).count
        retweet_count.each do |key, value|
            if self.id == key
                return value
            end
        end
        return 0
    end
end
