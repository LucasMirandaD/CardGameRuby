class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :set_url_options

  private

  def set_url_options
    ActiveStorage::Current.url_options = Rails.application.routes.default_url_options
  end
end
