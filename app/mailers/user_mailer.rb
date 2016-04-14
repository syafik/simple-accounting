class UserMailer < ActionMailer::Base # :nodoc:
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

 def absent_permissions_user(user, subject)
 	@user = user
 	subject = if subject == 1
 		"pengajuan cuti"
 else
 	"pengajuan izin"
 end
    mail(to: "hrd.pushjaw@gmail.com", subject: subject)
end
end
