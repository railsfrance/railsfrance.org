require 'test_helper'

class CacheTweetTest < ActiveSupport::TestCase
  test 'should be valid' do
    CacheTweet.last_tweets(3, 'railsfrance')
    assert !$redis.get("Twitter#railsfrance").nil?
    $redis.flushdb
  end

  test 'should catch Twitter API error and set message' do
    fake_account = 'random424242424242424242'
    CacheTweet.last_tweets(3, fake_account).each do |tweet|
      assert tweet['text'] == "Aucun tweet disponible"
    end
    assert $redis.get("Twitter##{fake_account}").nil?
    $redis.flushdb
  end
  

end
