require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  tests TagsController
  include Devise::TestHelpers

  setup do
    @question = Factory.create :question
  end

  test 'index' do
    get :index
    assert_response :success
    assert_template 'tags/index'
  end
end
