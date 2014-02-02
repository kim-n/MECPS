class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def new_user(user)
    @user = user
    mail :to => user.email, :subject => "Welcome #{user.name}!"
  end
  
  def reset_password(user)
    @user = user
    mail :to => user.email, :subject => "Password reset: #{user.name}!"
  end
end
