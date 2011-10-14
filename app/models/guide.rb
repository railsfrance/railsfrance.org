class Guide < ActiveRecord::Base
  attr_accessible :name, :description, :website

  validates :name, :presence => true, :length => { :maximum => 100 }
  validates :description, :presence => true, :length => { :maximum => 100 }
  validates_format_of :website, :with => /^(#{URI::regexp(%w(http https))})$/, :presence => true
end
