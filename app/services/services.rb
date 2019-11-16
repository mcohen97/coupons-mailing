class Services

  def self.expiration_emails_scheduler
    @services ||= services
    @services[:expiration_emails_scheduler]
  end

  def self.services
    { expiration_emails_scheduler: nil}
  end
end