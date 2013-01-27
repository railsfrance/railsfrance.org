class JobObserver < ActiveRecord::Observer

  def after_activation(record)
    unless Rails.env.development?
      Twitter.update I18n.t('twitter.new_job', title: record.to_s.truncate(80),
                            url: Rails.application.routes.url_helpers.job_url(record, host: "railsfrance.org"))
    end
  end
end

