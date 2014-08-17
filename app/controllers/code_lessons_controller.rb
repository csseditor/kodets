class CodeLessonsController < ApplicationController

  def new
    @code_lesson = CodeLesson.new
  end

  def create
    @track = Track.find params[:id]
    @code_lesson = @track.code_lessons.build(code_lesson_params)
    if @code_lesson.save
      redirect_to edit_code_lesson_path @code_lesson
    else
      flash[:warning] = 'Problem creating Code Lesson'
      redirect_to track_path @track
    end
  end

  def edit
    @code_lesson = CodeLesson.find params[:id]
  end

  def update
    @code_lesson = CodeLesson.find params[:id]
    if @code_lesson.update_attributes code_lesson_params
      redirect_to code_lesson_path @code_lesson
    else
      render :edit
    end
  end

  def index
    @track = Track.find params[:id]
    redirect_to track_path @track
  end

  def show
    @code_lesson = CodeLesson.find params[:id]
  end

  def destroy
    @code_lesson = CodeLesson.find params[:id]
    @track = @code_lesson.track
    if @code_lesson.destroy
      flash[:success] = 'Code Lesson deleted'
      redirect_to track_path @track
    else
      flash[:warning] = 'Problem deleting Code Lesson'
      redirect_to track_path @track
    end
  end

  private

  def code_lesson_params
    params.require(:code_lesson).permit(:name, :language_id, :lesson_content,
                                        :starting_code, :instructions,
                                        :hints, :order, :user_id,
                                        :organisation_id, :date_due,
                                        :correctness_test)
  end
end
