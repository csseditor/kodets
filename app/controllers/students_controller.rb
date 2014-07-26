class StudentsController < ApplicationController
  before_action :teacher_user, only: :edit
  before_action :authenticate_teacher!, only: [:index, :show, :destroy]

  def new
  end

  def edit
    @student = Student.find params[:id]
  end

  def index
    @students = Student.where(organisation_id: current_org.id)
  end

  def show
    @student = Student.find params[:id]
  end

  def destroy
    @student = Student.find params[:id]

    if @student.destroy
      flash[:notice] = 'Student deleted.'
      redirect_to students_path
    end
  end
end
