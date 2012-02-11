require 'spec_helper'

describe Search::Job do
  let(:search_job) { Search::Job.new({"cdi"=>"1", "cdd"=>"1", "freelance"=>"0", "internship"=>"0"}) }
  subject { search_job }
  it { should respond_to(:freelance)}
  it { should respond_to(:cdi)}
  it { should respond_to(:cdd)}
  it { should respond_to(:internship)}
  it { should respond_to(:remote)}

  it "should set attributes based on intialize attributes" do
    subject.cdi.should be_true
    subject.cdd.should be_true
    subject.freelance.should be_false
    subject.internship.should be_false
    subject.remote.should be_false
  end

  describe "#execute" do
    it "should only query against activated job" do
      search_job.execute.to_sql[Job.with_state(:activated).to_sql].should_not be_nil
    end
    it "should order by creation date" do
      search_job.execute.to_sql['ORDER BY created_at DESC'].should_not be_nil
    end
    it "should query against passed attributes on OR clause" do
      search_job.execute.to_sql["(cdi = 't' OR cdd = 't')"].should_not be_nil
    end
  end
end
