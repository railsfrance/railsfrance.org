require 'test_helper'

class QuestionsFlowTest < ActionController::IntegrationTest
  include Capybara::DSL

  DatabaseCleaner.strategy = :truncation
  self.use_transactional_fixtures = false

  setup do
    DatabaseCleaner.start
  end
  
  teardown do
    DatabaseCleaner.clean
  end

  test 'create question not signed in' do
    question = Factory.build(:question, user: nil)
    visit questions_path
    click_on 'Poser une question'
    assert current_path == new_question_path
    fill_in 'question_title', with: question.title
    fill_in 'question_description', with: question.description
    page.find('.button').click
    assert current_path == new_user_session_path
    user = Factory.create :user
    fill_in 'user_username', with: user.username
    fill_in 'user_password', with: user.password
    page.find('.button').click
    assert current_path == new_question_path
    assert page.has_content? question.title && question.description
    page.find('.button').click
    assert page.has_content? I18n.t('question.flash.created')
  end

  test 'tags autocomplete should work' do
    question = Factory.create(:question)
    Capybara.current_driver = :selenium
    visit new_question_path
    fill_in 'question_tag_list', with: 'tag4'
    choose_autocomplete_result 'tag42'
    assert page.find_field('question_tag_list').value == 'tag42, '
    Capybara.use_default_driver
  end

  def choose_autocomplete_result(text, input_id="input[data-autocomplete]")
    page.execute_script %Q{ $('#{input_id}').trigger("focus") }
    page.execute_script %Q{ $('#{input_id}').trigger("keydown") }
    sleep 1
    page.execute_script %Q{ $('.ui-menu-item a:contains("#{text}")').trigger("mouseenter").trigger("click"); }
  end
end
