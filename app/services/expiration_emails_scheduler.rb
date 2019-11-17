require 'sidekiq/api'

class ExpirationEmailsScheduler

  def schedule_expiration(promotion)
    exp_date = promotion.expiration_date
    if future_date?(exp_date)
      organization_administrators = Services.users_service.get_organization_administrators(promotion.organization_id)
      schedule_expiration_email(organization_administrators, promotion)
      schedule_expiration_warning_email(organization_administrators, promotion)
    end
  end

  def reschedule_expiration(promotion)
    
    expired = Rails.cache.read("Promotion:#{promotion.id}-expired")
    # if mails were already sent, it will be scheduling again
    if expired.nil?
      schedule_expiration(promotion)
      return
    end

    # check if new date is worth sending a new email
    diff = calculate_hours_diff(promotion.expiration_date, expired[:date])
    if diff < 3
    return
    end

    perform_rescheduling(promotion, expired)
  end

private

  def perform_rescheduling(promotion, expired)
    ss = Sidekiq::ScheduledSet.new
    job = ss.scan("\"job_id\":\"#{expired[:job]}\"").first

    job.reschedule(promotion.expiration_date)
    expiring_soon = Rails.cache.read("Promotion:#{promotion.id}-expiring_soon")
    
    if expiring_soon.nil?
      organization_administrators = Services.users_service.get_organization_administrators(promotion.organization_id)
      reschedule_expiration_warning_email(organization_administrators, promotion)
      schedule_expiration_warning_email(organization_administrators, promotion)
    else
      new_warning_date = determine_delivery_date(promotion.expiration_date)
      job = ss.scan("\"job_id\":\"#{expiring_soon[:job]}\"").first

      job.reschedule(new_warning_date)
    end
  end

  def future_date?(date)
    date >= DateTime.now
  end

  def schedule_expiration_email(administrators, promotion)
    administrators.each do |admin|
      add_job(true, promotion.expiration_date, promotion, admin[:email])
    end
  end

  def schedule_expiration_warning_email(administrators, promotion)
    date = determine_delivery_date(promotion.expiration_date)
    administrators.each do |admin|
      add_job(false, date, promotion, admin[:email])
    end
  end

  def reschedule_expiration_warning_email(administrators, promotion)
    date = determine_delivery_date(promotion.expiration_date)
    puts promotion.inspect
    administrators.each do |admin|
      # Tell now, date has changed
      PromotionsMailer.with(date:promotion.expiration_date, user_email: admin[:email],
        promotion_code: promotion.code, promotion_name: promotion.name).update_expiration_warning.deliver_later
      # Remind user the day before
      add_job(false,date, promotion, admin[:email])
    end
  end

  def add_job(expired,date, promotion, email)
    job = SendExpirationMailJob.set(wait_until: date).perform_later(expired: expired,
      date: date,
      user_email: email,
      promotion_id: promotion.id,
      promotion_code: promotion.code, 
      promotion_name: promotion.name)

    seconds = get_seconds_from_now(date)
    key = "Promotion:#{promotion.id}"
    key = expired ? key + "-expired" : key + "-expiring_soon"
    Rails.cache.write(key, {job: job.job_id, date: date}, expires_in: seconds.seconds)
  end

  def determine_delivery_date(exp_date)
    hours_diff = calculate_hours_diff(exp_date, DateTime.now.to_time)
    puts hours_diff
    if hours_diff < 24
      puts 'VENCE DENTRO DE POCO, SE ENVIA AHORA'
      DateTime.now 
    else
      exp_date.prev_day 
    end
  end

  def calculate_hours_diff(first_date, second_date)
    return ((first_date - second_date) / 3600)
  end

  def get_seconds_from_now(date)
    seconds = ((date - DateTime.now)).to_i
    return seconds
  end
end