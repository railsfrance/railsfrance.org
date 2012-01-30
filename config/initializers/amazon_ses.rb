ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base, {
  :access_key_id     => Settings.aws_ses.access_key_id,
  :secret_access_key => Settings.aws_ses.secret_access_key
}
