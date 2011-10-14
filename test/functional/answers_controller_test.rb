require 'test_helper'

class AnswersControllerTest < ActionController::TestCase
  tests AnswersController
  include Devise::TestHelpers

  def setup   
    @answer = Factory.create :answer
  end

  test 'create' do
    new_answer = Factory.build :answer
    sign_in new_answer.user
    assert_difference('Answer.count') do
      post :create, :question_id => new_answer.question.id, :answer => { :description => new_answer.description }
    end
    assert_redirected_to question_path new_answer.question
    assert_equal I18n.t('answer.flash.created'), flash[:notice]
  end

  test 'should vote up answer' do
    sign_in Factory.create :user
    get :vote, :question_id => @answer.question.id, :id => @answer.id, :vote => 'up'
    assert_redirected_to @answer.question
    assert_equal I18n.t('vote.flash.voted'), flash[:notice]
  end

  test 'should not vote up answer' do
    sign_in @answer.user
    assert_equal 0, @answer.up_votes
    assert_raise(CanCan::AccessDenied) { get :vote, :question_id => @answer.question.id, :id => @answer.id, :vote => 'up' }
    assert_equal 0, @answer.up_votes
  end

  test 'should vote down answer' do
    sign_in Factory.create :user
    get :vote, :question_id => @answer.question.id, :id => @answer.id, :vote => 'down'
    assert_redirected_to @answer.question
    assert_equal I18n.t('vote.flash.voted'), flash[:notice]
  end

  test 'should not vote down answer' do
    sign_in @answer.user
    assert_equal 0, @answer.down_votes
    assert_raise(CanCan::AccessDenied) { get :vote, :question_id => @answer.question.id, :id => @answer.id, :vote => 'down' }
    assert_equal 0, @answer.down_votes
  end
  
  test 'should accept answer' do
    sign_in @answer.question.user
    get :accept, :question_id => @answer.question.id, :id => @answer.id
    assert_redirected_to @answer.question
    assert_equal I18n.t('answer.flash.answered'), flash[:notice]
  end

  test 'should not accept answer' do
    sign_in Factory.create :user
    assert_raise(CanCan::AccessDenied) { get :accept, :question_id => @answer.question.id, :id => @answer.id }
  end
end
