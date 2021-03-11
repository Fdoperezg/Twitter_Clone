module TweeetsHelper
    def into_hash(tweeets) 
        hash = tweeets.map{|tweeet| { "id" => tweeet.id, "content" => tweeet.tweeet, "user_id" => tweeet.user_id, "like_count" => tweeet.likes.count, "retweets_count" => tweeet.count_retweet, "retweeted_from" => tweeet.tweeet_id }}
        api_tweeets = JSON.pretty_generate(hash)
    end

    def into_hash_and_date(tweeets)
        hash = tweeets.map{|tweeet| { "id" => tweeet.id, "content" => tweeet.tweeet, "user_id" => tweeet.user_id, "like_count" => tweeet.likes.count, "retweets_count" => tweeet.count_retweet, "retweeted_from" => tweeet.tweeet_id, "created_at" => tweeet.created_at }}
        api_tweeets = JSON.pretty_generate(hash)
    end  
end