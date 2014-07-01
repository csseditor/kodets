class OrganisationsController < ApplicationController

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

  def organisation_params
    params.require(:organisation).permit(:name, :email, :url, :location,
                                         :description)
  end
end
