require 'spec_helper'

describe QuestionsController do
  describe 'creation workflow' do
    let(:question) { build(:question, user: nil) }
    let(:user) { create(:user) }

    before { visit(questions_path) }

    it 'creates a question' do
      click_on 'Poser une question'
      expect(current_path).to eq(new_question_path)

      fill_in 'question_title', with: question.title
      fill_in 'question_description', with: question.description
      page.find('.button').click

      expect(current_path).to eq(new_user_session_path)

      fill_in 'user_username', with: user.username
      fill_in 'user_password', with: user.password
      page.find('.button').click

      expect(current_path).to eq(new_question_path)
      expect(page).to have_content(question.title && question.description)

      page.find('.button').click

      expect(page).to have_content(I18n.t('question.flash.created'))
    end
  end

  describe 'tags autocomplete' do
    let(:question) { create(:question) }
    before { visit(new_question_path) }

    xit 'should autocomplete', js: true do
      fill_in 'question_tag_list', with: 'tag4'

      page.execute_script %Q{ $('input[data-autocomplete]').trigger("focus") }
      page.execute_script %Q{ $('input[data-autocomplete]').trigger("keydown") }
      sleep 1
      page.execute_script %Q{ $('.ui-menu-item a:contains("tag4")').trigger("mouseenter").trigger("click"); }

      expect(page.find_field('question_tag_list').value).to eq('tag42, ')
    end
  end
end
