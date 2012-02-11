class User < ActiveRecord::Base
  extend FriendlyId
  include Addresseable
  include Gravtastic

  default_scope :order => 'username ASC'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  make_voter
  gravtastic :secure => true,:size => 22

  friendly_id :username, :use => :slugged
  paginates_per 20

  before_validation :website_prefix

  has_many :questions
  has_many :answers

  has_many :events

  attr_accessible :email, :password, :password_confirmation,
  :remember_me, :username, :website, :github, :twitter, :street, :city, :postal_code

  validates_presence_of :email
  validates :username, :presence => true, :uniqueness => true, :length => { :within => 3..42 }
  validates :github, :uniqueness => true, :allow_blank => true, :length => { :within => 0..40 }
  validates :twitter, :uniqueness => true, :allow_blank => true, :length => { :within => 0..15 }
  validates_format_of :website, :with => /^(#{URI::regexp(%w(http https))})$/, :allow_blank => true

  ROLES = %w(editor moderator administrator)

  def role?(base_role)
    return false unless (!role.empty? || role)
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  protected

  def website_prefix
    Rails.logger.info "WEBSITE PREFIX ! #{website.inspect}"
    unless website.blank? || website =~ %r{^https?://}
      self.website = "http://#{website}"
    end
  end
end
