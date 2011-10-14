class CacheTweet
  def self.last_tweets(nb, user)
    key = "Twitter##{user}"
    last_tweets = $redis.get(key)
    if last_tweets.nil?
      begin
        last_tweets = Twitter.user_timeline(user)[0..nb].inject([]) do |container, object|
          container << { 'text' => object.text, 'created_at' => object.created_at }
          container
        end
        $redis.set(key, last_tweets.to_json)
        $redis.expire(key, Settings.redis.expire_tweet)
      rescue
        last_tweets = [{ 'text' => "Aucun tweet disponible", 'created_at' => Time.now }]
      end
    else
      last_tweets = JSON.parse(last_tweets)
    end
    return last_tweets
  end
end
