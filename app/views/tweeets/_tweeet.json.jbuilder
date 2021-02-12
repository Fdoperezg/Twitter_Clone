json.extract! tweeet, :id, :content, :user_id, :tweet_id, :retweets_count, :created_at, :updated_at
json.url tweeet_url(tweeet, format: :json)
