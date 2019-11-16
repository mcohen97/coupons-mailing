class PromotionsMailer < ApplicationMailer

  def send_expiration_notification
    puts 'SE MANDA MAIL'
    @date = params[:date]
    @user_email = params[:user_email]
    @promotion_code  = params[:promotion_code]
    @promotion_name = params[:promotion_name]
    
    mail(to: @user_email, subject: 'Promotion of code ')
  rescue Net::SMTPFatalError => e
    puts 'ERROR'
    Rails.logger.error(e.message)
  end

end
