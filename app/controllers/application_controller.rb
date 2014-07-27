class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?
  include ApplicationHelper
  include Exceptions

  protect_from_forgery with: :exception

  layout :layout_by_resource

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :username, :title, :password, :password_confirmation)
    end

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:email, :first_name, :last_name, :title, :password,
               :password_confirmation, :current_password)
    end
  end

  def layout_by_resource
    devise_controller? ? 'devise' : 'application'
  end

  def org_edit_controller?
    controller_name == 'organisations' &&
    action_name == 'edit'
  end
end
