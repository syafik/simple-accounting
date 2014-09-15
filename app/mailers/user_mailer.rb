class UserMailer < ActionMailer::Base
  default from: "test.pushjaw@gmail.com"

  def send_accsess_new_user(user)
  	@user = user
  	mail(to: user.email, subject: "Welcome Board")
  end
end
