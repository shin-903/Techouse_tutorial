class ApplicationMailer < ActionMailer::Base
  from_email = ENV['FROM_EMAIL_ADDRESS'] # 環境変数から取得

  default from: from_email
  layout "mailer"
end
