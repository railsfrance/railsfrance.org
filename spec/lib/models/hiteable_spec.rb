require 'spec_helper'

describe Hiteable do
  let(:question) { create(:question) }

  describe "#hiteable_by?" do
    it { expect(question.hiteable_by?('bot')).to be_false }
    it { expect(question.hiteable_by?("<a href='http://www.unchaos.com/'> UnChaos </a> From Chaos To Order Hybrid Web Search Engine.(vadim_gonchar@unchaos.com)")).to be_false}
  end

  describe "#hit_view" do
    before { question.hit_view('Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.13 (KHTML, like Gecko) Chrome/0.X.Y.Z Safari/525.13.', '127.0.0.1') }
    it { expect($redis.get("Question:#{question.id}:127.0.0.1").nil?).to_not be_nil }
  end
end
