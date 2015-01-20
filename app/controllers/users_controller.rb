class UsersController < ApplicationController
  before_action :authenticate_teacher!, only: [:index, :destroy, :edit]

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]

    if @user.update_attributes user_params
      flash[:success] = 'User updated'
      redirect_to users_path
    else
      render :edit
    end
  end

  def show
    @user = User.find params[:id]

    unless current_org == @user.organisation
      redirect_to root_path
      flash[:warning] = 'You cannot access this user.'
    end
  end

  def index
    @users = User.all.where(organisation_id: current_org.id)
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy

    flash[:success] = "User: #{@user.username} deleted"
    redirect_to users_path
  end

  def user_params
    params.require(:user).permit(:name, :email, :username)
  end
end
