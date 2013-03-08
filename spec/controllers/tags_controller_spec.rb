require 'spec_helper'

describe TagsController do
  describe 'GET index' do
    subject { get(:index) }

    it { expect(subject).to be_successful }
    it { expect(subject).to render_template(:index) }
  end
end
