class CoursesController < ApplicationController
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
    @course = Course.find params[:permalink]
  end

  def show
    @course = Course.find params[:permalink]
  end

  def index
    @courses = Course.all.where(organisation_id: current_org.id)
  end

  private

  def course_params
    params.require(:course).permit(:name, :description, :colour)
  end
end
