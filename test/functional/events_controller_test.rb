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
    get :show, :id => @event.id
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
      post :create, :event => new_event.attributes
    end
    assert_redirected_to event_path assigns(:event)
    assert_equal I18n.t('event.flash.created'), flash[:notice]
  end

  test 'should edit own event' do
    sign_in @event.user
    get :edit, :id => @event.id
    assert_response :success
    assert_template 'events/edit'
  end

  test 'should not edit other one event' do
    sign_in Factory.create :user
    assert_raise(CanCan::AccessDenied) { get :edit, :id => @event.id }
  end

  test 'update' do
    sign_in @event.user
    @event.title = 'test'
    @event.description = 'test'
    put :update, :id => @event.id
    assert_redirected_to @event
    assert_equal I18n.t('event.flash.updated'), flash[:notice]
  end

  test 'should attend' do
    user = Factory.create :user
    sign_in user
    assert_equal@event.event_attendees.count, 0
    get :attend, :id => @event.id
    assert_equal @event.event_attendees.count, 1
    assert_redirected_to @event
    assert_equal I18n.t('event.flash.attended'), flash[:notice]
  end

  test 'should not attend' do
    sign_in @event.user
    assert_equal @event.event_attendees.count, 0
    assert_raise(CanCan::AccessDenied) { get :attend, :id => @event.id }
    assert_equal @event.event_attendees.count, 0
  end

  test 'should unattend' do
    user = Factory.create :user
    sign_in user
    get :attend, :id => @event.id
    assert_equal @event.event_attendees.count, 1
    assert_redirected_to @event
    get :unattend, :id => @event.id
    assert_equal @event.event_attendees.count, 0
    assert_redirected_to @event
    assert_equal I18n.t('event.flash.unattended'), flash[:notice]
  end

  test 'should not unattend' do
    sign_in @event.user
    attendees = @event.event_attendees.count
    assert_raise(CanCan::AccessDenied) { get :unattend, :id => @event.id }
    assert_equal @event.event_attendees.count, attendees
  end
end
