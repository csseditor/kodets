class StudentImportsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_teacher!

  def new
    @student_import = StudentImport.new
    @user = User.new
  end

  def create
    begin
      @student_import = StudentImport.new(params[:student_import].merge({ current_org: current_org }))
      saved = @student_import.save
    rescue Exceptions::MaximumPopulationReached => e
      flash[:warning] = e.message
      redirect_to new_student_import_path
    rescue Exceptions::NoFileGiven => e
      flash[:warning] = e.message
      redirect_to new_student_import_path
    rescue => e
      flash[:warning] = e.class.to_s + ': ' + e.message
      redirect_to new_student_import_path
    else
      if saved
        flash[:notice] = 'Students imported successfully!'
        redirect_to users_path
      else
        render :new
      end
    end
  end

  def create_student
    @user = User.new user_params

    if @user.save
      flash[:success] = 'User created!'
      redirect_to users_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :username, :password,
                                 :password_confirmation, :organisation_id)
  end
end
