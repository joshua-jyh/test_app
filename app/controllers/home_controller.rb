class HomeController < ApplicationController
  def index; end

  def status
    render json: {
      state: "ok",
      environment: Rails.env,
      checked_at: Time.current.iso8601
    }
  end
end
