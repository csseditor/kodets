class CoursesController < ApplicationController
  before_action :authenticate_user!
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
    @tracks = @course.tracks
  end

  def index
    @courses = current_org.courses
  end

  def destroy
    @course = Course.find params[:id]
    @course.destroy
    flash[:success] = 'Course deleted'
    redirect_to courses_path
  end

  private

  def course_params
    params.require(:course).permit(:name, :description, :colour)
  end
end
