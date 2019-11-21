class InvitationEmailsSender

  def send_invitation_email(invitation_info)
    puts 'SE VA A ENVIAR EL MAIL'
    UserInvitationsMailer.with(email_invited: invitation_info.email_invited,
       sender_name: invitation_info.sender_name,
       sender_surname:  invitation_info.sender_surname,
       organization_name: invitation_info.organization_name, 
       invitation_code: invitation_info.code,
       registration_url: ENV['USER_REGISTRATION_URL']).send_invitation.deliver_later
  rescue ArgumentError => e
    Rails.loggger.error(e.message)
  end
end