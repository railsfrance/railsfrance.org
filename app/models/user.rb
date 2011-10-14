class User < ActiveRecord::Base
  extend FriendlyId
  include Addresseable
  include Gravtastic
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  make_voter
  gravtastic :secure => true,:size => 22

  friendly_id :username, :use => :slugged

  geocoded_by :address
  after_validation :geocode

  has_many :questions
  has_many :answers

  has_many :events
  has_many :news
  has_many :comments
  has_many :event_attendee


  attr_accessible :email, :password, :password_confirmation,
  :remember_me, :username, :website, :github, :twitter, :street, :city, :postal_code

  validates_presence_of :email
  validates :username, :presence => true, :uniqueness => true, :length => { :within => 4..12 }
  validates :github, :uniqueness => true, :allow_blank => true, :length => { :within => 0..40 }
  validates :twitter, :uniqueness => true, :allow_blank => true, :length => { :within => 0..15 }
  validates :postal_code, :allow_blank => true, :format => { :with => /^[0-9]{5}$/ }
  validates_format_of :website, :with => /^(#{URI::regexp(%w(http https))})$/, :allow_blank => true

  ROLES = %w(editor moderator administrator)

  def role?(base_role)
    return false unless (!role.empty? || role)
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end
end
