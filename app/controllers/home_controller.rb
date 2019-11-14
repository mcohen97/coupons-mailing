# frozen_string_literal: true

class HomeController < ApplicationController

  def index
    PromotionsMailer.welcome_email.deliver_later
  end
end
