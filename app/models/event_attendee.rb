class EventAttendee < ActiveRecord::Base
  belongs_to :user
  belongs_to :event, :counter_cache => :attendees_count

  validates_presence_of :user, :event
end
