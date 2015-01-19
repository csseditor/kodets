class RegistrationsController < Devise::RegistrationsController
  before_action :teacher_user, only: [:edit, :update]

  def create
    @org = Organisation.new(name: '', email: sign_up_params[:email], max_users: 50)
    @org.save

    build_resource(sign_up_params.merge({ organisation_id: @org.id }))

    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      @org.destroy
      clean_up_passwords resource
      respond_with resource
    end
  end

  def edit
    render :edit
  end

  def update
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)

    # required for settings form to submit when password is left blank
    if account_update_params[:password].blank?
      account_update_params.delete("password")
      account_update_params.delete("password_confirmation")
      account_update_params.delete("current_password")

      @user = User.find current_user.id

      if @user.update_attributes(account_update_params)
        set_flash_message :notice, :updated
        # Sign in the user bypassing validation in case their password changed
        sign_in @user, bypass: true
        redirect_to after_update_path_for(@user)
      else
        render :edit
      end
    else
      self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
      prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

      resource_updated = update_resource(resource, account_update_params)
      yield resource if block_given?
      if resource_updated
        if is_flashing_format?
          flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
            :update_needs_confirmation : :updated
          set_flash_message :notice, flash_key
        end
        sign_in resource_name, resource, bypass: true
        respond_with resource, location: after_update_path_for(resource)
      else
        clean_up_passwords resource
        respond_with resource
      end
    end
  end

  private

  def after_sign_up_path_for(resource)
    edit_organisation_path resource.organisation
  end
end
