class ApplicationController < ActionController::Base
  include ApplicationHelper

  protect_from_forgery with: :exception

  layout :layout_by_resource

  protected

  def layout_by_resource
    devise_controller? ? 'devise' : 'application'
  end
end
