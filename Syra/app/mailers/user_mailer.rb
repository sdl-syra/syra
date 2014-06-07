class UserMailer < ActionMailer::Base
  # default from: "syracorp@gmail.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def registration_confirmation(user)

    mail :to => user.email, :from => "syracorp@gmail.com", :subject => "Subject line"

  end

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end

  def send_code(user,service,proposition)
    @user = user.name
    @service = service.title
    @url = "http://localhost:3000/propositions/"+proposition.id.to_s
    @code = ServicesHelper.generate_code
    proposition.code = @code
    proposition.save
    mail :to => user.email, :from => "noreply@syra.com", :subject => "Le mail de ta vie"
  end

end
