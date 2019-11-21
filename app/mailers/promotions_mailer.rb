class PromotionsMailer < ApplicationMailer

  def send_expiring_soon_notification
    @when = decide_today_or_tomorrow_in_text(params[:date])
    set_common_attributes
    send_mail("Promotion #{@promotion_code} will expire soon")
  end

  def send_expired_notification
    set_common_attributes
    send_mail("Promotion #{@promotion_code} has expired")
  end

  def update_expiration_warning
    puts 'ACTUALIZAR EL VENCIMIENTO'
    set_common_attributes
    @date = params[:date]
    send_mail("Promotion #{@promotion_code}'s expiration date has been updated")
  end

private

  def set_common_attributes
    @user_email = params[:user_email]
    @promotion_code  = params[:promotion_code]
    @promotion_name = params[:promotion_name]
  end

  def send_mail(subject)
    mail(to: @user_email, subject: subject)
  rescue Net::SMTPFatalError, ArgumentError => e
    puts 'ERROR'
    Rails.logger.error(e.message)
  end

  def decide_today_or_tomorrow_in_text(date)
    puts date.to_date
    puts Date.today
    return date.to_date == Date.today ? "today" : "tomorrow" 
  end

end
