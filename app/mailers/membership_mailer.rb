class MembershipMailer < ActionMailer::Base
  default from: "tengo-hombre@lunchatron.com"
  
  def notify(membership)
    @membership = membership
    mail(to: membership.email, subject: 'Welcome to Tesserapto!')
  end
end
