# frozen_string_literal: true

class HomeController < ApplicationController

  def index
    SendExpirationMailJob.set(wait: 2.minutes).perform_later('diegomarcel27@hotmail.com')
    render json: {message: 'Mail scheduled to be sent successfully!'}, status: :ok
  end
end
