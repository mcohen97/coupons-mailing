class PromotionsMailer < ApplicationMailer

  def send_expiration_notification
    @date = params[:date]
    @user_email = params[:user_email]
    @url  = 'http://example.com/login'
    mail(to: @user_email, subject: 'Welcome to My Awesome Site')
  end

end
