class Services

  def self.expiration_emails_scheduler
    @services ||= services
    @services[:expiration_emails_scheduler]
  end

  def self.users_service
    @services ||= services
    @services[:users_servie]
  end

  def self.invitation_emails_sender
    @services ||= services
    @services[:invitation_emails_sender]
  end

  def self.services
    expiration_emails_scheduler = ExpirationEmailsScheduler.new()
    users_service = UsersService.new()
    invitation_emails_sender = InvitationEmailsSender.new()
    { expiration_emails_scheduler: expiration_emails_scheduler,
      users_servie: users_service,
      invitation_emails_sender: invitation_emails_sender}
  end
end