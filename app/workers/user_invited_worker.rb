class UserInvitedWorker
  include Sneakers::Worker

  from_queue ENV['INVITED_USERS_QUEUE'],
  exchange: ENV['USERS_EXCHANGE'],
  exchange_type: :topic,
  routing_key: ENV['INVITED_USERS_BINDING_KEY'],
  env: nil,
  durable: true

  def work(raw_data)
    puts 'INVITACION RECIBIDA'
    raw_data = JSON.parse(raw_data)
    invitation_info = UserInvitationInfo.new(raw_data)
    puts 'SE VA A LLAMAR SERVICIO'
    Services.invitation_emails_sender.send_invitation_email(invitation_info)
    ack! 
  end

end