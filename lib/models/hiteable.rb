module Hiteable
  include Bots

  def hiteable_by?(ua)
    WILD_CARDS.each { |wc| return false if ua and ua.downcase.include? wc }
    true unless LIST.include? ua
  end

  def hit_view(ua, ip)
    if hiteable_by?(ua)
      key = "#{self.class.to_s}:#{self.id}:#{ip}"
      if $redis.get(key).nil?
        $redis.set(key, Time.now.to_i)
        self.class.increment_counter(:views, self.id)
        $redis.expire(key, Settings.redis.expire_view)
      end
    end
  end
end
