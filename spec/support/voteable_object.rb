require 'spec_helper'

shared_examples_for "a voteable object" do
  let(:user) { create(:user) }

  it "counts an up vote" do
    expect(subject.vote(user, 'up')).to be_true
  end

  it "counts a down vote" do
    expect(subject.vote(user, 'down')).to be_true
  end

  it "Does not count a vote if the user owns the object" do
    expect(subject.voteable_by?(subject.user)).to be_false
  end

  it "Does not count a vote if the user has already voted" do
    subject.vote(user, 'up')

    expect(subject.voteable_by?(user)).to be_false
  end
end
