class News < ActiveRecord::Base
  extend FriendlyId

  default_scope :order => 'created_at DESC'

  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy

  friendly_id :title, :use => :slugged
  paginates_per 10

  attr_accessible :title, :description, :user_id, :slug

  delegate :page, :to => :comments, :prefix => true, :allow_nil => true
  delegate :username, :to => :user, :prefix => true, :allow_nil => true
  delegate :gravatar_url, :to => :user, :prefix => true, :allow_nil => true

  validates_presence_of :user, :description
  validates :title, :presence => true, :length => { :maximum => 100 }
end
