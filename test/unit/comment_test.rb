require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  setup do
    @comment = Factory.build :comment_event
  end

  test 'should be valid' do
    assert @comment.valid?
  end

  test 'should not be valid without user' do
    @comment.user = nil
    assert @comment.invalid?
  end

  test 'should not be valid without description' do
    @comment.description = nil
    assert @comment.invalid?
  end

  test 'should not be valid without commentable' do
    @comment.commentable = nil
    assert @comment.invalid?
  end
end
