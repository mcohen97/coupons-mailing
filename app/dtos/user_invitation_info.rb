class UserInvitationInfo
  attr_reader :email_invited, :sender_name, :sender_surname, :code, :organization_name

  def initialize(data)
    @email_invited = data['email_invited']
    @sender_name = data['sender_name']
    @sender_surname = data['sender_surname']
    @code = data['invitation_code']
    @organization_name = data['organization_name']
  end

end