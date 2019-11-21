class UpdatedPromotionsWorker
  include Sneakers::Worker
  
  from_queue ENV['UPDATED_PROMOTIONS_QUEUE'],
  exchange: ENV['PROMOTIONS_EXCHANGE'],
  exchange_type: :topic,
  routing_key: ENV['UPDATED_PROMOTIONS_BINDING_KEY'],
  env: nil,
  durable: true


  def work(raw_data)
    puts 'PROMOCION EDITADA'
    Rails.logger.info('PROMOCION EDITADA')
    raw_data = JSON.parse(raw_data)
    promotion_info = PromotionInfo.new(raw_data)
    Services.expiration_emails_scheduler.reschedule_expiration(promotion_info)
    ack! # we need to let queue know that message was received
  end

end