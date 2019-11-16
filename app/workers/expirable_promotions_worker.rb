class ExpirablePromotionsWorker
  include Sneakers::Worker
  # env is set to nil since by default the actual queue name would have the env appended to the end
  from_queue ENV['EXPIRABLE_PROMOTIONS_QUEUE'], 
  env: nil,
  durable: true


  # work method receives message payload in raw format
  # in our case it is JSON encoded string
  # which we can pass to service without
  # changes
  def work(raw_data)
    raw_data = JSON.parse(raw_data)
    
    ack! # we need to let queue know that message was received
  end

  def correct_data_provided(raw_data)
    return !raw_data['promotion_id'].nil? && !raw_data['organization_id'].nil?
  end
end