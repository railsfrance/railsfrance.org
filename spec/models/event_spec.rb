require 'spec_helper'

describe Event do
  it_should_behave_like "an addresseable object"

  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:street) }
  it { should validate_presence_of(:postal_code) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:date) }

  it { should ensure_length_of(:title).is_at_most(100) }
  it { should ensure_length_of(:description).is_at_most(500) }

  it { should allow_value("http://railsfrance.org").for(:website) }
  it { should allow_value("https://railsfrance.org").for(:website) }

  # We need to fix the website validation before unxit
  xit { should allow_value("railsfrance.org").for(:website) }
  xit { should_not allow_value(1234).for(:website) }
  xit { should_not allow_value("1234").for(:website) }

  it { should_not allow_value(Time.now - 1.day).for(:date) }
  it { should allow_value(Time.now).for(:date) }
  it { should allow_value(Time.now + 1.day).for(:date) }

  it { should belong_to(:user) }
end
