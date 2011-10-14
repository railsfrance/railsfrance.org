require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  tests CommentsController
  include Devise::TestHelpers

  test 'create comment event' do
    comment = Factory.build :comment_event
    sign_in comment.user
    assert_difference('Comment.count') do
      post :create, :event_id => comment.commentable.id, :comment => { :description => comment.description }
    end
    assert_redirected_to event_path comment.commentable
    assert_equal I18n.t('comment.flash.created'), flash[:notice]
  end

  test 'create comment news' do
    comment = Factory.build :comment_news
    sign_in comment.user
    assert_difference('Comment.count') do
      post :create, :news_id => comment.commentable.id, :comment => { :description => comment.description }
    end
    assert_redirected_to news_path comment.commentable
    assert_equal I18n.t('comment.flash.created'), flash[:notice]
  end
end
