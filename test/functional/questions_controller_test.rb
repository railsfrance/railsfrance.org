require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  tests QuestionsController
  include Devise::TestHelpers

  setup do
    @question = Factory.create :question
  end

  test 'index' do
    get :index
    assert_response :success
    assert_template 'questions/index'
  end

  test 'index with tag' do
    get :index, :tag => @question.tag_list[0]    
    assert_response :success
    assert_template 'questions/index'
  end

  test 'show' do
    get :show, :id => @question.id
    assert_response :success
    assert_template 'questions/show'
  end

  test 'new' do
    get :new
    assert_response :success
    assert_template 'questions/new'
  end

  test 'create' do
    new_question = Factory.build(:question)
    sign_in new_question.user
    assert_difference('Question.count') do
      post :create, :question => new_question.attributes
    end
    assert_redirected_to question_path assigns(:question)
    assert_equal I18n.t('question.flash.created'), flash[:notice]
  end

  test 'should edit own question' do
    sign_in @question.user
    get :edit, :id => @question.id
    assert_response :success
    assert_template 'questions/edit'
  end

  test 'should not edit other one question' do
    sign_in Factory.create :user
    assert_raise(CanCan::AccessDenied) { get :edit, :id => @question.id }
  end

  test 'update' do
    sign_in @question.user
    @question.title = "test"
    @question.description = "test"
    put :update, :id => @question.id
    assert_redirected_to @question
    assert_equal I18n.t('question.flash.updated'), flash[:notice]
  end

  test 'should vote up question' do
    user = Factory.create :user
    sign_in user
    get :vote, :id => @question.id, :vote => 'up'
    assert_redirected_to @question
    assert_equal I18n.t('vote.flash.voted'), flash[:notice]
  end

  test 'should not vote up question' do
    sign_in @question.user
    assert_equal 0, @question.up_votes
    assert_raise(CanCan::AccessDenied) { get :vote, :id => @question.id, :vote => 'up' }
    assert_equal 0, @question.up_votes
  end

  test 'should vote down question' do
    user = Factory.create :user
    sign_in user
    get :vote, :id => @question.id, :vote => 'down'
    assert_redirected_to @question
    assert_equal I18n.t('vote.flash.voted'), flash[:notice]
  end

  test 'should not vote down question' do
    sign_in @question.user
    assert_equal 0, @question.down_votes
    assert_raise(CanCan::AccessDenied) { get :vote, :id => @question.id, :vote => 'down' }
    assert_equal 0, @question.down_votes
  end
end
