require 'spec_helper'

describe AnswersController do
  let(:answer) { build(:answer) }
  let(:user) { create(:user) }
  before { visit(question_path(answer.question)) }

  it 'creates an answer' do
    fill_in 'answer_description', with: answer.description
    page.find('.button').click

    expect(current_path).to eq(new_user_session_path)

    fill_in 'user_username', with: user.username
    fill_in 'user_password', with: user.password

    page.find('.button').click

    expect(current_path).to eq(question_path(answer.question))
    expect(page).to have_content(answer.description)

    page.find('.button').click

    expect(page).to have_content(I18n.t('answer.flash.created'))
  end
end
