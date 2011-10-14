require 'test_helper'

# TODO
# TEST IMAGE UPLOAD

class JobTest < ActiveSupport::TestCase
  setup do
    @job = Factory.build :job
  end

  test 'should be valid' do
    assert @job.valid?
  end

  test 'should not be valid without needed fields' do
    @job.company = nil
    assert @job.invalid?

    @job.title = nil
    assert @job.invalid?

    @job.street = nil
    assert @job.invalid?

    @job.city = nil
    assert @job.invalid?

    @job.description = nil
    assert @job.invalid?
  end

  test 'should not be valid with bad url' do
    @job.url = 'HEIN'
    assert @job.invalid?
  end

  test 'should not be valid with bad postal code' do
    @job.postal_code = nil
    assert @job.invalid?
    @job.postal_code = '876554'
    assert @job.invalid?
  end

  test 'should not be valid with bad email' do
    @job.email = nil
    assert @job.invalid?
    @job.postal_code = 'qwerty.fr'
    assert @job.invalid?
  end

  test 'should be localized after validation' do
    @job.save
    assert @job.latitude
    assert @job.longitude
  end

  test 'should have initial state to pending' do
    assert @job.state == 'pending'
  end
end
