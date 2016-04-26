require 'spec_helper'

describe JobObserver do
  let(:job) { FactoryGirl.create(:job) }
  let(:observer) { JobObserver.send(:new) }

  describe '#after_activation' do
    it 'should call Twitter.update with a well formated message' do
      mock_job_twitter_update!(job)
      observer.after_activation(job)
    end
  end
end
