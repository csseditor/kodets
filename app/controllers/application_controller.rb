class ApplicationController < ActionController::Base
  include CustomDeviseHelper
  before_filter :user_parameters, if: :user_controller?
  before_filter :organisation_parameters, if: :organisation_controller?

  protect_from_forgery with: :exception

  protected

  def user_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:first_name, :last_name, :email, :password, :organisation_id,
               :password_confirmation, :username)
    end

    devise_parameter_sanitizer.for(:sign_in) do |u|
      u.permit(:email, :password, :remember_me)
    end

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:first_name, :last_name, :email, :password, :current_password,
               :password_confirmation, :username, :bio)
    end
  end

  def organisation_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :username, :email, :password, :password_confirmation,
               :url)
    end

    devise_parameter_sanitizer.for(:sign_in) do |u|
      u.permit(:email, :password, :remember_me)
    end

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:name, :username, :email, :password, :password_confirmation,
               :url)
    end
  end
end
