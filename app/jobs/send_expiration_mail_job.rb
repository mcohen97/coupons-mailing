class SendExpirationMailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    date= Date.new(2018, 11, 11)
    PromotionsMailer.with(date: date, user_mail: args[:user_mail]).send_expiration_notification.deliver_later
  end
end
