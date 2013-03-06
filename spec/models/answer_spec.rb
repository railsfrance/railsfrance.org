require 'spec_helper'

describe Answer do
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:question) }
  it { should validate_presence_of(:description) }

  it { should belong_to(:user) }
  it { should belong_to(:question) }

  it_should_behave_like "a voteable object" do
    subject { build(:answer) }
  end
end
