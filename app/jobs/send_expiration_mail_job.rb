class SendExpirationMailJob < ApplicationJob
  queue_as :default
  discard_on ActiveJob::DeserializationError


  def perform(user_mail)
    date= Date.new(2018, 11, 11)
    puts "USER MAIL #{user_mail}"
    PromotionsMailer.with(date: date, user_email: user_mail).send_expiration_notification.deliver_now
  end
end
