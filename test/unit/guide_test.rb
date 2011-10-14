require 'test_helper'

class GuideTest < ActiveSupport::TestCase
  setup do
    @guide = Factory.build :guide
  end

  test 'should be valid' do
    assert @guide.valid?
  end

  test 'should not be valid without name' do
    @guide.name = nil
    assert @guide.invalid?
  end

  test 'should not be valid without website' do
    @guide.website = nil
    assert @guide.invalid?
  end

  test 'should not be valid without description' do
    @guide.description = nil
    assert @guide.invalid?
  end
end
