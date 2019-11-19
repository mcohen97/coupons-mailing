class UserInvitedWorker
  include Sneakers::Worker
  # env is set to nil since by default the actual queue name would have the env appended to the end
  from_queue ENV['INVITED_USERS_QUEUE'],
  amqp: ENV['INVITATIONS_QUEUE_SERVER_URL'],
  env: nil,
  durable: true


  # work method receives message payload in raw format
  # in our case it is JSON encoded string
  # which we can pass to service without
  # changes
  def work(raw_data)
  end

end