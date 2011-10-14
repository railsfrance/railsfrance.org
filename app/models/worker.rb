class Worker < ActiveRecord::Base
  include Addresseable

  default_scope :order => 'city ASC'

  attr_accessible :name, :website, :street,
  :postal_code, :city

  geocoded_by :address

  validates :name, :presence => true, :length => { :maximum => 100 }
  validates :city, :presence => true
  validates_format_of :website, :with => /^(#{URI::regexp(%w(http https))})$/, :presence => true
end
