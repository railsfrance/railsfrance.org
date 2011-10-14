module Addresseable
  def address
    # Forcing the country could be a good idea to ensure good coordinates
    # [street, postal_code, city, 'France'].join(', ')
    [street, postal_code, city].join(', ')
  end
end
