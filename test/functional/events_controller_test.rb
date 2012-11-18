require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  tests EventsController
  include Devise::TestHelpers

  setup do
    @event = Factory.create :event
  end

  test 'index' do
    get :index
    assert_response :success
    assert_template 'events/index'
  end

  test 'show' do
    get :show, id: @event.id
    assert_response :success
    assert_template 'events/show'
  end

  test 'new' do
    get :new
    assert_response :success
    assert_template 'events/new'
  end

  test 'create' do
    new_event = Factory.build(:event)
    sign_in new_event.user
    assert_difference('Event.count') do
      post :create, event: new_event.attributes
    end
    assert_redirected_to event_path assigns(:event)
    assert_equal I18n.t('event.flash.created'), flash[:notice]
  end

  test 'should edit own event' do
    sign_in @event.user
    get :edit, id: @event.id
    assert_response :success
    assert_template 'events/edit'
  end

  test 'should not edit other one event' do
    sign_in Factory.create :user
    assert_raise(CanCan::AccessDenied) { get :edit, id: @event.id }
  end

  test 'update' do
    sign_in @event.user
    @event.title = 'test'
    @event.description = 'test'
    put :update, id: @event.id
    assert_redirected_to @event
    assert_equal I18n.t('event.flash.updated'), flash[:notice]
  end
end
