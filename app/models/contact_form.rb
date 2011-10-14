class ContactForm < BasicActiveModel
  attr_accessor :email, :subject, :body

  validates_presence_of :email, :subject, :body
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
end
