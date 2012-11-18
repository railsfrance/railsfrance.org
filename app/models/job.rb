class Job < ActiveRecord::Base
  extend FriendlyId
  include Addresseable

  image_accessor :logo
  attr_accessor :contracts_error

  friendly_id :title, :use => :slugged

  validates_presence_of :company, :street, :city, :description, :postal_code
  validates_format_of :url, :with => /^(#{URI::regexp(%w(http https))})$/, :allow_blank => true
  validates :email, :presence => true, :format => {:with => Devise::email_regexp}
  validates :title, :presence => true, :length => { :maximum => 100 }
  validate :validate_contracts

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

    event :soft_delete do
      transition :activated => :soft_deleted
    end
  end

  def to_s; "#{company} - #{title}" end

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
