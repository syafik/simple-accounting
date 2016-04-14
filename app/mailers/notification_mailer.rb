class NotificationMailer < ActionMailer::Base  # :nodoc:
  default from: "Admin Pushjaw<test.pushjaw@gmail.com>"

  def submit_reimbursement(reimbursement)
    @reimbursement = reimbursement
    mail(to: @reimbursement.user.email, subject: "[Pushjaw] Pengajuan Reimbursement")
  end

  def approve_reimbursement(reimbursement)
    @reimbursement = reimbursement
    mail(to: @reimbursement.user.email, subject: "[Pushjaw] Konfirmasi Pengajuan Reimbursement")
  end
  def reject_reimbursement(reimbursement)
    @reimbursement = reimbursement
    mail(to: @reimbursement.user.email, subject: "[Pushjaw] Konfirmasi Pengajuan Reimbursement")
  end

  def reminder_absents(users)
  end
end
