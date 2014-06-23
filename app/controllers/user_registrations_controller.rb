class UserRegistrationsController < Devise::RegistrationsController
  before_action :authenticate_organisation, only: :new

  def new
    build_resource({})
    respond_with self.resource
  end
end
