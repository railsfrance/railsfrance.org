require 'test_helper'

class WorkerTest < ActiveSupport::TestCase
  setup do
    @worker = Factory.build :worker
  end

  test 'should be valid' do
    assert @worker.valid?
  end

  test 'should not be valid without name' do
    @worker.name = nil
    assert @worker.invalid?
  end

  test 'should not be valid without website' do
    @worker.website = nil
    assert @worker.invalid?
  end

  test 'should not be valid without city' do
    @worker.city = nil
    assert @worker.invalid?
  end
end
