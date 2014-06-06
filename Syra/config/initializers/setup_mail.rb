ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
:address => "smtp.gmail.com",
:port => 587,
:domain => "whatever.org",
:user_name => "syracorp",
:password => "syra2014",
:authentication => "plain",
:enable_starttls_auto => true
}