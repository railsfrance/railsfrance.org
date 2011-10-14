module Voteable
  def voteable_by?(user)
    (user != self.user) && !user.voted?(self)
  end

  def vote(user, direction)
    if %w(up down).include? direction
      self.class.record_timestamps = false
      user.send("#{direction}_vote", self)
      self.class.record_timestamps = true
      I18n.t('vote.flash.voted')
    end
  end
end
