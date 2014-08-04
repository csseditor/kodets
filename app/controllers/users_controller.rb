class UsersController < ApplicationController
  before_action :teacher_user, only: [:index, :destroy]

  def index
    @users = User.all.where(organisation_id: current_org.id)
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy
  end
end
