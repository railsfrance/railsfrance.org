require 'test_helper'

class HiteableTest < ActiveSupport::TestCase
  setup do
    @object = FactoryGirl.create :question
  end

  test 'should not be hiteable if bot' do
    assert !@object.hiteable_by?('bot')
    assert !@object.hiteable_by?("<a href='http://www.unchaos.com/'> UnChaos </a> From Chaos To Order Hybrid Web Search Engine.(vadim_gonchar@unchaos.com)")
  end

  test 'should hit view' do
    assert @object.hit_view('Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.13 (KHTML, like Gecko) Chrome/0.X.Y.Z Safari/525.13.', '127.0.0.1')
    assert !$redis.get("Question:#{@object.id}:127.0.0.1").nil?
    $redis.flushdb
  end

end
