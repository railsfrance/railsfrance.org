require 'spec_helper'

describe EventsController do
  describe 'GET index' do
    subject { get(:index) }

    it { expect(subject).to be_successful }
    it { expect(subject).to render_template(:index) }
  end

  describe 'GET show' do
    let(:event) { create(:event) }
    subject { get(:show, id: event.id) }

    it { expect(subject).to be_successful }
    it { expect(subject).to render_template(:show) }
  end

  describe 'GET index' do
    subject { get(:new) }

    it { expect(subject).to be_successful }
    it { expect(subject).to render_template(:new) }
  end

  describe 'POST create' do
    let(:event) { build(:event) }
    before { sign_in(event.user) }
    subject { post :create, event: event.attributes }

    it { expect{subject}.to change{ Event.count }.by(1) }
    it { expect(subject).to redirect_to(event_path(Event.first)) }
    it { expect{subject}.to change{flash[:notice]}.to(I18n.t('event.flash.created')) }
  end

  describe 'GET edit' do
    let(:event) { create(:event) }
    subject { get(:edit, id: event.id) }

    context 'when the logged user is the event owner' do
      before { sign_in(event.user) }

      it { expect(subject).to be_successful }
      it { expect(subject).to render_template(:edit) }
    end

    context 'when the logged user is not the event owner' do
      before { sign_in(create(:user)) }

      it { expect{subject}.to raise_error(CanCan::AccessDenied) }
    end

    context 'when the user is not logged in' do
      it { expect{subject}.to raise_error(CanCan::AccessDenied) }
    end
  end

  describe 'PUT update' do
    let(:event) { create(:event) }
    let(:new_attributes) { { title: 'titletest', description: 'desctest'} }
    subject { put(:update, id: event.id, event: new_attributes) }

    context "when the logged user is the event owner" do
      before { sign_in(event.user) }

      it { expect(subject).to redirect_to(event.reload) }
      it { expect{subject}.to change{ Event.first.title }.to('titletest') }
      it { expect{subject}.to change{ Event.first.description }.to('desctest') }
      it { expect{subject}.to change{flash[:notice]}.to(I18n.t('event.flash.updated')) }
    end
  end
end
