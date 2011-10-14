require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  setup do
    @answer = Factory.build :answer
  end

  test 'should be valid' do
    assert @answer.valid?
  end

  test 'should not be valid without user' do
    @answer.user = nil
    assert @answer.invalid?
  end

  test 'should not be valid without question' do
    @answer.question = nil
    assert @answer.invalid?
  end

  test 'should not be valid without description' do
    @answer.description = nil
    assert @answer.invalid?
  end

  test 'should count up vote' do
    user = Factory.create :user
    assert @answer.vote(user, 'up')
  end

  test 'sould count down vote' do
    user = Factory.create :user
    assert @answer.vote(user, 'down')
  end

  test 'should not count vote if user owns answer' do
    assert !@answer.voteable_by?(@answer.user)
  end

  test 'should not count vote if user already voted' do
    user = Factory.create :user
    @answer.vote(user, 'up')
    assert !@answer.voteable_by?(@answer.user)
  end
end
