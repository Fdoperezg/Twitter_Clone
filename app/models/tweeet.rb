class Tweeet < ApplicationRecord
    validates :tweeet, presence: true
    belongs_to :user
    paginates_per 10
end
