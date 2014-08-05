class CoursesController < ApplicationController
  before_action :teacher_user, only: [:new, :create, :edit, :update, :destroy]
  def new
    @course = Course.new
  end

  def create
    @course = current_org.courses.build course_params
    if @course.save
      flash[:success] = 'Course created'
      redirect_to course_path @course
    else
      render :new
    end
  end

  def edit
    @course = Course.find params[:id]
  end

  def update
    @course = Course.find params[:id]
    if @course.update_attributes course_params
      flash[:success] = 'Course updated'
      redirect_to @course
    else
      render :edit
    end
  end

  def show
    @course = Course.find params[:id]
  end

  def index
    @courses = current_org.courses
  end

  private

  def course_params
    params.require(:course).permit(:name, :description, :colour)
  end
end
