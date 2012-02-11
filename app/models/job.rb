class Job < ActiveRecord::Base
  extend FriendlyId
  include Addresseable

  image_accessor :logo
  attr_accessor :contracts_error

  friendly_id :title, :use => :slugged

  geocoded_by :address

  validates_presence_of :company, :street, :city, :description
  validates_format_of :url, :with => /^(#{URI::regexp(%w(http https))})$/, :allow_blank => true
  validates :email, :presence => true, :format => {:with => Devise::email_regexp}
  validates :postal_code, :presence => true, :format => {:with => /^[0-9]{5}$/}
  validates :title, :presence => true, :uniqueness => true, :length => { :maximum => 100 }
  validate :validate_contracts

  after_validation :geocode

  paginates_per 10

  state_machine :initial => :pending do
    after_transition :pending => :confirmed do |job, trans|
      job.generate_token
    end

    after_transition :confirmed => :activated do |job, trans|
      job.send :notify_observers, :after_activation
    end

    event :confirm do
      transition :pending => :confirmed
    end

    event :activate do
      transition :confirmed => :activated
    end
  end

  def to_s; title end

  def contracts
    {cdi: cdi, cdd: cdd, freelance: freelance, internship: internship}.delete_if {|k,v| !v}.keys
  end

  def generate_token
    update_attribute(:token, SecureRandom.hex(13))
  end

  private
  def validate_contracts
    errors.add(:contracts_error, "Selectionner au moins un type de contrat") unless (cdd or cdi or freelance or internship)
  end

end
