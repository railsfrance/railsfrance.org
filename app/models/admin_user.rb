class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  protected

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    conditions = {:email => conditions.delete(:username)}
    where(conditions).first
  end

  def username; email; end
end
