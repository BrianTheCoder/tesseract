class InviteMailer < ActionMailer::Base
  default from: "tengo-hombre@lunchatron.com"
  
  def notify(invite)
    @invite = invite
    mail(to: invite.email, subject: 'Welcome to Lunchatron!')
  end
end
