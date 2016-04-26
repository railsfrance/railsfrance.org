def mock_job_twitter_update!(job)
  twitter_client = double('Twitter::REST::Client')
  expect(Twitter::REST::Client).to receive(:new)
                                    .and_return(twitter_client)
  expect(twitter_client).to receive(:update)
                             .with(I18n.t(
                                    'twitter.new_job', title: job.title.truncate(60),
                                    url: Rails.application.routes.url_helpers.job_url(job, host: 'railsfrance.org')))
end
