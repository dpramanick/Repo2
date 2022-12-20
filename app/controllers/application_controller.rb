# frozen_string_literal: true

# rubocop:disable Style/Documentation

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name postcode telephone latitude longitude])
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[name postcode telephone latitude longitude])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name postcode telephone latitude longitude])
  end
end

# rubocop:enable Style/Documentation
