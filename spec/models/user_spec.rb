require 'spec_helper'

describe User do
  it_should_behave_like "an addresseable object"

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:username) }

  it { should ensure_length_of(:username).is_at_least(3).is_at_most(42) }
  it { should ensure_length_of(:github).is_at_least(0).is_at_most(40) }
  it { should ensure_length_of(:twitter).is_at_least(0).is_at_most(15) }

  context "with an existing user" do
    let!(:user) { create(:user) }

    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:github) }
    it { should validate_uniqueness_of(:twitter) }
  end

  it { should allow_value("http://railsfrance.org").for(:website) }
  it { should allow_value("https://railsfrance.org").for(:website) }
  it { should allow_value("railsfrance.org").for(:website) }

  # We need to fix the website validation before unxit
  xit { should_not allow_value(1234).for(:website) }
  xit { should_not allow_value("1234").for(:website) }

  context '#website_prefix' do
    it "Does not double the http prefix on website" do
      user = build(:user, website: "http://railsfrance.org")
      user.valid?
      expect(user.website).to eql("http://railsfrance.org")
    end
  end

  context "#role?" do
    pending
  end
end
