module Addresseable
  extend ActiveSupport::Concern

  included do
    validates_format_of :postal_code, with: /^[0-9]{5}$/, :if => :postal_code?
    geocoded_by :address
    after_validation :geocode, if: lambda {|o| o.postal_code? && o.street? && o.city?}
  end

  def address
    [street, postal_code, city].join(', ')
  end
end
