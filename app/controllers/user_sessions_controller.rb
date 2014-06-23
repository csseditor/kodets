class UserSessionsController < Devise::SessionsController
  before_action :authenticate_organisation, only: [:new, :create]

  def create
    self.resource = warden.authenticate!(auth_options)

    if resource.organisation_id == current_organisation.id
      flash[:info] = "Welcome back, #{resource.first_name}!" if is_flashing_format?
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      sign_out resource
      flash[:warning] = 'Incorrect email/password combination'
      render 'new'
    end
  end
end
