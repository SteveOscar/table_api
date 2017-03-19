class UserMailer < ActionMailer::Base
  default :from => "stevenoscarolson@gmail.com"

  def registration_confirmation(user)
    @user = user
    # mail(:to => "#{user.username} <#{user.email}>", :subject => "Registration Confirmation")
    mail(:to => "steveoscaro@gmail.com", :subject => "Registration Confirmation")
  end

end
