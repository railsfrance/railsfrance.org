require 'spec_helper'

describe QuestionsController do
  describe 'GET index' do
    subject { get(:index) }

    it { expect(subject).to be_successful }
    it { expect(subject).to render_template(:index) }
  end

  describe 'GET index (with tag)' do
    let(:question) { build(:question) }
    subject { get(:index, tag: question.tag_list[0]) }

    it { expect(subject).to be_successful }
    it { expect(subject).to render_template(:index) }
  end

  describe 'GET show' do
    let(:question) { create(:question) }
    subject { get(:show, id: question.id) }

    it { expect(subject).to be_successful }
    it { expect(subject).to render_template(:show) }
  end

  describe 'GET new' do
    subject { get(:new) }

    it { expect(subject).to be_successful }
    it { expect(subject).to render_template(:new) }
  end

  describe 'POST create' do
    let(:question) { build(:question) }
    before { sign_in(question.user) }
    subject { post(:create, question: question.attributes) }

    it { expect{subject}.to change{Question.count}.by(1) }
    it { expect(subject).to redirect_to(Question.first) }
    it { expect{subject}.to change{flash[:notice]}.to(I18n.t('question.flash.created')) }
  end

  describe 'GET edit' do
    let(:question) { create(:question) }
    subject { get(:edit, id: question.id) }

    context "when the logged user is the question owner" do
      before { sign_in(question.user) }

      it { expect(subject).to be_successful }
      it { expect(subject).to render_template(:edit) }
    end

    context "when the logged user is not the question owner" do
      before{ sign_in(create(:user)) }

      it { expect{subject}.to raise_error(CanCan::AccessDenied) }
    end
  end

  describe 'PUT update' do
    let(:question) { create(:question) }
    let(:new_attributes) { { title: 'titletest', description: 'desctest'} }
    subject { put(:update, id: question.id, question: new_attributes) }

    context "when the logged user is the question owner" do
      before { sign_in(question.user) }

      it { expect(subject).to redirect_to(question.reload) }
      it { expect{subject}.to change{ Question.first.title }.to('titletest') }
      it { expect{subject}.to change{ Question.first.description }.to('desctest') }
      it { expect{subject}.to change{flash[:notice]}.to(I18n.t('question.flash.updated')) }
    end
  end

  describe 'GET vote' do
    let(:question) { create(:question) }

    context "when the logged user is not the question owner" do
      let(:user) { create(:user) }
      before { sign_in(user) }

      describe 'vote up' do
        subject { get(:vote, id: question.id, vote: 'up') }

        it { expect(subject).to redirect_to(question) }
        it { expect{subject}.to change{flash[:notice]}.to(I18n.t('vote.flash.voted')) }
      end

      describe 'vote down' do
        subject { get(:vote, id: question.id, vote: 'down') }

        it { expect(subject).to redirect_to(question) }
        it { expect{subject}.to change{flash[:notice]}.to(I18n.t('vote.flash.voted')) }
      end
    end

    context "when the logged user is the question owner" do
      before { sign_in(question.user) }

      describe 'vote up' do
        subject { get(:vote, id: question.id, vote: 'up') }

        it { expect{subject rescue  nil}.to_not change{question.up_votes} }
        it { expect{subject}.to raise_error(CanCan::AccessDenied) }
      end

      describe 'vote down' do
        subject {get(:vote, id: question.id, vote: 'down') }

        it { expect{subject rescue  nil}.to_not change{question.down_votes} }
        it { expect{subject}.to raise_error(CanCan::AccessDenied) }
      end
    end
  end
end
