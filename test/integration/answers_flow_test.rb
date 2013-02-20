require 'test_helper'

class AnswersFlowTest < ActionController::IntegrationTest
  include Capybara::DSL

  test 'create answer not signed in' do
    answer = FactoryGirl.build(:answer)
    visit question_path answer.question
    fill_in 'answer_description', with: answer.description
    page.find('.button').click
    assert current_path == new_user_session_path
    user = FactoryGirl.create :user
    fill_in 'user_username', with: user.username
    fill_in 'user_password', with: user.password
    page.find('.button').click
    assert current_path == question_path(answer.question)
    assert page.has_content? answer.description
    page.find('.button').click
    assert page.has_content? I18n.t('answer.flash.created')
  end
end
