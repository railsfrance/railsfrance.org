require 'spec_helper'

describe UsersController do
  
  describe "#new" do
    let!(:user) { Factory.build(:user) }
    before(:each) { visit new_user_registration_path }

    it "create a new user" do
      within("#new_user") do
        fill_in 'user_username', :with => user.username
        fill_in 'user_email', :with => user.email
        fill_in 'user_password', :with => user.password
        fill_in 'user_password_confirmation', :with => user.password
      end
      page.find('.button').click
      page.should have_content(I18n.t('devise.registrations.inactive_signed_up'))
    end
  end

end
