require 'spec_helper'

describe EventsController do
  let(:event) { build(:event) }
  let(:user) { create(:user) }

  before { visit(events_path) }

  it 'creates an event' do
    click_on 'addEvent'
    fill_in 'event_title', with: event.title
    fill_in 'event_description', with: event.description
    fill_in 'event_street', with: event.street
    fill_in 'event_city', with: event.city
    fill_in 'event_postal_code', with: event.postal_code
    fill_in 'event_date', with: event.date
    page.find('.button').click

    expect(current_path).to eq(new_user_session_path)

    fill_in 'user_username', with: user.username
    fill_in 'user_password', with: user.password
    page.find('.button').click

    expect(current_path).to eq(new_event_path)
    expect(page).to have_content(event.title && event.description)

    page.find('.button').click

    expect(page).to have_content(I18n.t('event.flash.created'))
  end
end
