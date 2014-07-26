class OrganisationsController < ApplicationController
  before_action :authenticate_user_with_org!, only: [:edit, :update, :show, :destroy]

  def new
  end

  def create
  end

  def edit
    @organisation = Organisation.find_by ref: params[:ref]
  end

  def update
    @organisation = Organisation.find_by ref: params[:ref]
    if @organisation.update_attributes organisation_params
      notice = 'Details saved.'
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
    @organisation = Organisation.find_by ref: params[:ref]
  end

  def index
    @organisations = Organisation.all
  end

  def destroy
  end

  private

  def authenticate_user_with_org!
    org = Organisation.find_by(ref: params[:ref])
    unless current_teacher && current_teacher.organisation_id == org.id
      flash[:warning] = 'You do not have permission to access this page.'
      redirect_to root_path
    end
  end

  def organisation_params
    params.require(:organisation).permit(:name, :email, :url, :location,
                                         :description)
  end
end
