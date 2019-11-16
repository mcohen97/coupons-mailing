class Services

  def self.expiration_emails_scheduler
    @services ||= services
    @services[:expiration_emails_scheduler]
  end

  def self.services
    expiration_emails_scheduler = ExpirationEmailsScheduler.new()
    { expiration_emails_scheduler: expiration_emails_scheduler}
  end
end