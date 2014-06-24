class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :first_name, :last_name, :organisation_id, :username,
               :password, :password_confirmation)
    end

    devise_parameter_sanitizer.for(:sign_in) do |u|
      u.permit(:email, :password, :organisation_ref, :remember_me)
    end

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:email, :first_name, :last_name, :organisation_id, :username,
               :password, :password_confirmation, :current_password)
    end
  end
end
