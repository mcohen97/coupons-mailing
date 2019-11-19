class InvitationEmailsSender

  def send_invitation_email(invitation_info)
    UserInvitationsMailer.with(email_invited: invitation_info.invitation_info,
       sender_name: invitation_info.sender_name, 
       organization_name: invitation_info.organization_name, 
       invitation_code: invitation_info.code,
       registration_url: ENV['USER_REGISTRATION_URL']).invitation_email.deliver_later
  end

end