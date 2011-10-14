require 'test_helper'

class ResourcesControllerTest < ActionController::TestCase
  tests ResourcesController
  include Devise::TestHelpers

  test 'index' do
    get :index
    assert_response :success
    assert_template 'resources/index'
  end
end
