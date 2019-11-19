class UserInvitationInfo
  attr_reader :email_invited, :sender_name, :code, :organization_name

  def initialize(data)
    @invitation_info = data[:email_invited]
    @sender_name = data[:sender_name]
    @code = data[:invitation_code]
    @organization_name = data[:organization_name]
  end

end