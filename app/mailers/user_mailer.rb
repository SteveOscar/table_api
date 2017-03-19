class UserMailer < ActionMailer::Base
  default :from => "tablegrabcommunication@gmail.com"

  def registration_confirmation(user)
    @user = user
    # mail(:to => "#{user.username} <#{user.email}>", :subject => "Registration Confirmation")
    mail(:to => "#{user.email}", :subject => "TableGrab Registration Confirmation")
  end

end
