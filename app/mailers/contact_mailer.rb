class ContactMailer < ActionMailer::Base
  layout 'mail'

  default from: Settings.mailer.from
  default_url_options[:host] = Settings.mailer.host

  def contact contact_form
    @contact = contact_form
    @mail_title = subject = "Railsfrance.org - What's up dude ? Message from #{@contact.email}"

    mail(to: "railsfrance.org@gmail.com",
    subject: subject)
  end

  def confirm_job job
    @job = job
    @mail_title = subject = "Railsfrance.org - Confirmation de votre annonce d'emploi"

    mail(to: job.email,
    subject: subject)
  end

  def valid_job job
    @job = job
    @mail_title = subject = "Railsfrance.org - Validation de votre annonce d'emploi"
    mail(to: job.email,
    subject: subject)
  end
end
