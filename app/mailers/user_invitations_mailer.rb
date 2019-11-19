class UserInvitationsMailer < ApplicationMailer

  def send_invitation
    @email_invited = params[:email_invited]
    @sender_name = params[:sender_name]
    @invitation_code = params[:invitation_code]
    @organization_name = params[:organization_name]
    @registration_url = "#{params[:registration_url]}/#{@invitation_code}"
    mail(to: @email_invited, subject: @sender_name + ' invited you to join Coupons')
  end

end
