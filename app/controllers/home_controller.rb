# frozen_string_literal: true

class HomeController < ApplicationController

  def index
    SendExpirationMailJob.set(wait: 30.seconds).perform_later({user_email: 'diegomarcel27@hotmail.com'})
  end
end
