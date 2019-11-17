class SendExpirationMailJob < ApplicationJob
  queue_as :default
  discard_on ActiveJob::DeserializationError


  def perform(data)
    if data[:expired]
      PromotionsMailer.with(user_email: data[:user_email],
        promotion_code: data[:promotion_code], promotion_name: data[:promotion_name]).send_expired_notification.deliver_now
    else
      PromotionsMailer.with(date: data[:date], user_email: data[:user_email],
        promotion_code: data[:promotion_code], promotion_name: data[:promotion_name]).send_expiring_soon_notification.deliver_now
    end
  end
end
