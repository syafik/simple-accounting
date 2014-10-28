class UserMailer < ActionMailer::Base
  default from: "test.pushjaw@gmail.com"

  def send_accsess_new_user(user)
  	@user = user
  	mail(to: user.email, subject: "Welcome Board")
  end

  def send_lembur_approved_user(user)
  	@user = user
  	mail(to: user.email, subject: "lembur anda diterima")
  end

 def send_lembur_rejected_user(user)
  	@user = user
  	mail(to: user.email, subject: "lembur anda ditolak")
 end

end
