if Rails.env.production?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name      => "app22273498@heroku.com",
    :password       => "rm1wtrsr",
    :domain         => 'heroku.com',
    :enable_starttls_auto => true
  }
end