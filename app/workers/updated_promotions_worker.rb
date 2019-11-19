class UpdatedPromotionsWorker
  include Sneakers::Worker
  # env is set to nil since by default the actual queue name would have the env appended to the end
  from_queue ENV['UPDATED_PROMOTIONS_QUEUE'],
  amqp: ENV['PROMOTIONS_QUEUE_SERVER_URL'],
  exchange: ENV['PROMOTIONS_EXCHANGE'],
  exchange_type: :topic,
  routing_key: ENV['UPDATED_PROMOTIONS_BINDING_KEY'],
  env: nil,
  durable: true


  # work method receives message payload in raw format
  # in our case it is JSON encoded string
  # which we can pass to service without
  # changes
  def work(raw_data)
    puts 'PROMOCION EDITADA'
    raw_data = JSON.parse(raw_data)
    promotion_info = PromotionInfo.new(raw_data)
    Services.expiration_emails_scheduler.reschedule_expiration(promotion_info)
    ack! # we need to let queue know that message was received
  end

end