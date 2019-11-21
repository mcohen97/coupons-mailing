class CreatedPromotionsWorker
  include Sneakers::Worker

  from_queue ENV['CREATED_PROMOTIONS_QUEUE'],
  exchange: ENV['PROMOTIONS_EXCHANGE'],
  exchange_type: :topic,
  routing_key: ENV['CREATED_PROMOTIONS_BINDING_KEY'],
  env: nil,
  durable: true


  def work(raw_data)
    puts 'PROMOCION CREADA'
    Rails.logger.info('PROMOCION CREADA')
    raw_data = JSON.parse(raw_data)
    promotion_info = PromotionInfo.new(raw_data)
    Services.expiration_emails_scheduler.schedule_expiration(promotion_info)
    ack! 
  end

end