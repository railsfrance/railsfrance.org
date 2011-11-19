class Event < ActiveRecord::Base
  extend FriendlyId
  include Addresseable
  include Adapter::Model

  default_scope :order => 'date DESC'
  belongs_to :user, :counter_cache => :events_count

  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :event_attendees, :dependent => :destroy

  has_many :attendees, :through => :event_attendees, :source => :user

  friendly_id :title, :use => :slugged

  paginates_per 10

  geocoded_by :address
  after_validation :geocode

  attr_accessible :title, :description, :city, :postal_code,
  :street, :date, :website

  delegate :page, :to => :comments, :prefix => true, :allow_nil => true
  delegate :username, :to => :user, :prefix => true, :allow_nil => true
  delegate :gravatar_url, :to => :user, :prefix => true, :allow_nil => true

  validates_presence_of :city, :street, :user
  validates :title, :presence => true, :length => { :maximum => 100 }
  validates :description, :presence => true, :length => { :maximum => 500 }
  validates :postal_code, :presence => true, :format => {:with => /^[0-9]{5}$/}
  validates_format_of :website, :with => /^(#{URI::regexp(%w(http https))})$/, :allow_blank => true
  validates :date, :date => { :after => Time.now, :message => I18n.t('event.error.date') }, :presence => true

  def attendable_by?(user)
    (!self.attendees.include? user) && (!user.id.nil?) && (user != self.user) && (self.date > Time.now)
  end

  def unattendable_by?(user)
    (self.attendees.include? user) && (!user.id.nil?) && (user != self.user)
  end
end
