require 'test_helper'

class CommentsFlowTest < ActionController::IntegrationTest
  include Capybara::DSL

  test 'create comment event not signed in' do
    comment = Factory.build(:comment_event)
    visit event_path comment.commentable
    fill_in 'comment_description', :with => comment.description
    page.find('.button').click
    assert current_path == new_user_session_path
    user = Factory.create :user
    fill_in 'user_username', :with => user.username
    fill_in 'user_password', :with => user.password
    page.find('.button').click
    assert current_path == event_path(comment.commentable)
    assert page.has_content? comment.description
    page.find('.button').click
    assert page.has_content? I18n.t('comment.flash.created')
  end

  test 'create comment news not signed in' do
    comment = Factory.build(:comment_news)
    visit news_path comment.commentable
    fill_in 'comment_description', :with => comment.description
    page.find('.button').click
    assert current_path == new_user_session_path
    user = Factory.create :user
    fill_in 'user_username', :with => user.username
    fill_in 'user_password', :with => user.password
    page.find('.button').click
    assert current_path == news_path(comment.commentable)
    assert page.has_content? comment.description
    page.find('.button').click
    assert page.has_content? I18n.t('comment.flash.created')
  end
end
