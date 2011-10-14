require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  setup do
    @question = Factory.build :question
  end

  test 'should be valid' do
    assert @question.valid?
  end

  test 'should not be valid without user' do
    @question.user = nil
    assert @question.invalid?
  end

  test 'should not be valid with bad title' do
    @question.title = nil
    assert @question.invalid?
    @question.title = (0..500).map{ ('a'..'z').to_a[rand(26)] }.join
    assert @question.invalid?
  end

  test 'should not be valid without description' do
    @question.description = nil
    assert @question.invalid?
  end

  test 'should count up vote' do
    user = Factory.create :user
    assert @question.vote(user, 'up')
  end

  test 'should count down vote' do
    user = Factory.create :user
    assert @question.vote(user, 'down')
  end

  test 'should not count vote if user owns question' do
    assert !@question.voteable_by?(@question.user)
  end

  test 'should not count vote if user already voted' do
    user = Factory.create :user
    @question.vote(user, 'up')
    assert !@question.voteable_by?(@question.user)
  end
end
