require 'spec_helper'

describe JobObserver do
  let(:job) { Factory(:job) }
  let(:observer) { JobObserver.send(:new) }

  describe '#after_activation' do
    it "should call Twitter.update with a well formated message" do
      Twitter.should_receive(:update).with(I18n.t(
                                                  'twitter.new_job', title: job.company.truncate(20) + ' - ' + job.title.truncate(40),
                                                  url: Rails.application.routes.url_helpers.job_url(job, host: "railsfrance.org")))
      observer.after_activation(job)
    end
  end
end
