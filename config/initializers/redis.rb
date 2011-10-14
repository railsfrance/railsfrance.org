require 'redis'

$redis = Redis.new(Settings.redis.to_hash)
