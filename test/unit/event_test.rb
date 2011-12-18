require 'test_helper'

class EventTest < ActiveSupport::TestCase
  setup do
    @event = Factory.build :event
  end

  test 'should be valid' do
    assert @event.valid?
  end

  test 'should not be valid without title' do
    @event.title = nil
    assert @event.invalid?
  end

  test 'should not be valid without description' do
    @event.description = nil
    assert @event.invalid?
  end

  test 'should not be valid with bad description' do
    @event.description = nil
    assert @event.invalid?
    @event.description = (0..500).map{ ('a'..'z').to_a[rand(26)] }.join
    assert @event.invalid?
  end

  test 'should not be valid without city' do
    @event.city = nil
    assert @event.invalid?
  end

  test 'should not be valid without postal code' do
    @event.postal_code = nil
    assert @event.invalid?
  end

  test 'should not be valid without street' do
    @event.street = nil
    assert @event.invalid?
  end

  test 'should not be valid without date' do
    @event.date = nil
    assert @event.invalid?
  end

  test 'should not be valid with past date' do
    @event.date = '1942-01-01 00:42:42'
    assert @event.invalid?
  end

  test 'should be localized after validation' do
    @event.save
    assert @event.latitude
    assert @event.longitude
  end
end
