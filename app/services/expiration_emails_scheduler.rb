class ExpirationEmailsScheduler

  def schedule_expiration(promotion)
    exp_date = promotion.expiration_date
    if future_date(exp_date)
      organization_administrators = UsersService.get_organization_administrators(promotion.organization_id)
      schedule_expiration_email(organization_administrators, promotion)
      schedule_expiration_warining_email(promotion)
    end
  end

private

  def schedule_expiration_email(administrators, promotion)
    schedule(administrators, promotion, promotion.expiration_date)
  end

  def schedule_expiration_warining_email(administrators, promotion)
    diff_in_hours = (promotion.expiration_date - DateTime.now) / 1.hours
    if diff_in_hours < 24
      # if expires in less than a day, send it right away
      schedule(administrators, promotion, promotion.expiration_date, nil)
    else
      schedule(administrators, promotion, promotion.expiration_date, promotion.prev_day)
    end
  end

  def schedule(administrators, promotion, date)
    administrators.each do |admin|
      PromotionsMailer.with(date: date, user_email: admin.email, 
                            promotion_code: promotion.code, promotion_name: promotion.name).send_expiration_notification
    end
  end

end