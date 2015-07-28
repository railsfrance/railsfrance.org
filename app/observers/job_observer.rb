class JobObserver < ActiveRecord::Observer
  def after_activation(record)
    unless Rails.env.development?
      twitter_client.update I18n.t('twitter.new_job', title: record.title.truncate(60),
                            url: Rails.application.routes.url_helpers.job_url(record, host: "railsfrance.org"))
    end
  end

  private

  def twitter_client
    @twitter_client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = Settings.twitter.consumer_key
      config.consumer_secret = Settings.twitter.consumer_secret
      config.access_token = Settings.twitter.oauth_token
      config.access_token_secret = Settings.twitter.oauth_token_secret
    end
  end
end
