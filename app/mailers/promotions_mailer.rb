class PromotionsMailer < ApplicationMailer

  def send_expiration_notification
    puts 'SE MANDA MAIL'
    @date = params[:date]
    @user_email = params[:user_email]
    @url  = 'http://example.com/login'
    mail(to: @user_email, subject: 'Welcome to My Awesome Site')
  rescue Net::SMTPFatalError => e
    puts 'ERROR'
    Rails.logger.error(e.message)
  end

end
