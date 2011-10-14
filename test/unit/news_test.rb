require 'test_helper'

class NewsTest < ActiveSupport::TestCase
  setup do
    @news = Factory.build :news
  end

  test 'should be valid' do
    assert @news.valid?
  end

  test 'should not be valid without user' do
    @news.user = nil
    assert @news.invalid?
  end

  test 'should not be valid without title' do
    @news.title = nil
    assert @news.invalid?
  end

  test 'should not be valid without description' do
    @news.description = nil
    assert @news.invalid?
  end
end
