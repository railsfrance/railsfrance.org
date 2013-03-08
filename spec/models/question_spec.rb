require 'spec_helper'

describe Question do
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:title) }
  it { should ensure_length_of(:title).is_at_most(100) }

  it { should belong_to(:user) }
  it { should belong_to(:accepted_answer)
      .with_foreign_key(:accepted_answer_id)
      .class_name("Answer") }
  it { should have_many(:answers).dependent(:destroy) }

  it { should allow_mass_assignment_of(:title) }
  it { should allow_mass_assignment_of(:description) }
  it { should allow_mass_assignment_of(:tag_list) }

  it_should_behave_like "a voteable object" do
    subject { build(:question) }
  end
end
