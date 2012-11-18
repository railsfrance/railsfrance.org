require 'test_helper'

class EventsFlowTest < ActionController::IntegrationTest
  include Capybara::DSL

  test 'create event not signed in' do
    event = Factory.build(:event)
    visit events_path
    click_on 'addEvent'
    fill_in 'event_title', with: event.title
    fill_in 'event_description', with: event.description
    fill_in 'event_street', with: event.street
    fill_in 'event_city', with: event.city
    fill_in 'event_postal_code', with: event.postal_code
    fill_in 'event_date', with: event.date
    page.find('.button').click
    assert current_path == new_user_session_path
    user = Factory.create :user
    fill_in 'user_username', with: user.username
    fill_in 'user_password', with: user.password
    page.find('.button').click
    assert current_path == new_event_path
    assert page.has_content? event.title && event.description
    page.find('.button').click
    assert page.has_content? I18n.t('event.flash.created')
  end  
end
