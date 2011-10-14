require 'test_helper'

class NewsControllerTest < ActionController::TestCase
  tests NewsController
  include Devise::TestHelpers
  
  setup do
    @news = Factory.create :news
  end

  test 'index' do
    get :index
    assert_response :success
    assert_template 'news/index'
  end

  test 'show' do
    get :show, :id => @news.id
    assert_response :success
    assert_template 'news/show'
  end
end
