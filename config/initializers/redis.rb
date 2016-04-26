require 'redis'

$redis = Redis.new(url: ENV["REDISTOGO_URL"])
