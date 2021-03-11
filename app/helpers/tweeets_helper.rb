module TweeetsHelper
    def into_hash(tweeets) 
        hash = tweeets.map{|tweeet| { "id" => tweeet.id, "content" => tweeet.tweeet, "user_id" => tweeet.user_id, "like_count" => tweeet.likes.count, "retweets_count" => tweeet.count_retweet, "retweeted_from" => tweeet.tweeet_id }}
        api_tweeets = JSON.pretty_generate(hash)
    end
end