require 'spec_helper'

describe ResourcesController do
  describe 'GET index' do
    subject { get(:index) }

    it { expect(subject).to be_succes }
    it { expect(subject).to render_template(:index) }
  end
end
