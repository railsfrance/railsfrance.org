require 'spec_helper'

describe AnswersController do
  let(:answer) { create(:answer) }
  let(:user) { create(:user) }

  describe 'POST create' do

    let(:post_call) do
      -> { post(:create,
               question_id: answer.question.id,
               answer: { description: answer.description })
      }
    end
    before { sign_in(answer.user) }

    context "around create" do
      it { expect{ post_call.call }.to change{ Answer.count }.by(1) }
    end

    context "after create" do
      before { post_call.call }

      it { expect(response).to redirect_to(answer.question) }
      it { expect(flash[:notice]).to eql(I18n.t('answer.flash.created')) }
    end
  end

  describe 'GET vote' do
    context "with a logged user" do
      before { sign_in(user) }

      describe 'vote up' do
        before { get(:vote, question_id: answer.question.id, id: answer.id, vote: 'up') }

        it { expect(response).to redirect_to(answer.question) }
        it { expect(flash[:notice]).to eql(I18n.t('vote.flash.voted'))}
      end

      describe 'vote down' do
        before { get(:vote, question_id: answer.question.id, id: answer.id, vote: 'down') }

        it { expect(response).to redirect_to(answer.question) }
        it { expect(flash[:notice]).to eql(I18n.t('vote.flash.voted'))}
      end
    end

    context "with the answer owner as the logged user" do
      before { sign_in(answer.user) }

      describe 'vote up' do
        let(:vote_call) do
          -> { get(:vote, question_id: answer.question.id, id: answer.id, vote: 'up') }
        end

        it { expect{ vote_call.call rescue  nil }.to_not change{ answer.up_votes } }
        it { expect{ vote_call.call }.to raise_error(CanCan::AccessDenied) }
      end

      describe 'vote down' do
        let(:vote_call) do
          -> { get(:vote, question_id: answer.question.id, id: answer.id, vote: 'down') }
        end

        it { expect{ vote_call.call rescue  nil }.to_not change{ answer.down_votes } }
        it { expect{ vote_call.call }.to raise_error(CanCan::AccessDenied) }
      end
    end
  end

  describe 'GET accept' do
    let(:accept_call) { ->{ get(:accept, question_id: answer.question.id, id: answer.id) } }

    context 'the logged user is the question owner' do
      before do
        sign_in(answer.question.user)
        accept_call.call
      end

      it { expect(response).to redirect_to(answer.question) }
      it { expect(flash[:notice]).to eq(I18n.t('answer.flash.answered')) }
    end

    context 'the logged user is not the question owner' do
      before { sign_in(user) }

      it { expect{ accept_call.call }.to raise_error(CanCan::AccessDenied) }
    end
  end
end
