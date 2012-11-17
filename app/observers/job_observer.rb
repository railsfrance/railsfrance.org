class JobObserver < ActiveRecord::Observer

  def after_activation(record)
    Twitter.update I18n.t('twitter.new_job',
      title: record.company.truncate(20)  + ' - ' + record.title.truncate(40),
      url: Rails.application.routes.url_helpers.job_url(record, host: "railsfrance.org"))
  end
end
