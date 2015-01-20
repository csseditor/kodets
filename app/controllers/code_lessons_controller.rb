class CodeLessonsController < ApplicationController
  before_action :authenticate_user!

  layout 'code_lesson', only: :show

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
    @track = @code_lesson.track
    @language = Language.find @code_lesson.language_id
  end

  def update
    @code_lesson = CodeLesson.find params[:id]
    @track = @code_lesson.track
    @language = Language.find @code_lesson.language_id
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
    @track = @code_lesson.track
    @language = Language.find @code_lesson.language_id
    @creator = User.find @code_lesson.user_id

    code_lesson_info_with_markdown
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

  def stats
    @code_lesson = CodeLesson.find params[:id]
    @track = @code_lesson.track
  end

  # The function that code is posted to, to be evaluated
  def evaluate
    @cl = CodeLesson.find(params[:lesson_id])

    @sandie = Sandie.new(language: Language.find(@cl.language_id).code_eval_slug)
    @code = @sandie.evaluate(code: params[:user_code])

    render json: @code.merge({ pass: "true\n" }).to_json.inspect
  end

  private

  def code_lesson_params
    params.require(:code_lesson).permit(:name, :language_id, :lesson_content,
                                        :starting_code, :instructions,
                                        :hints, :order, :user_id,
                                        :organisation_id, :date_due,
                                        :correctness_test)
  end

  def code_lesson_info_with_markdown
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                       autolink: true,
                                       space_after_headers: true)

    @cl_lesson_content = markdown.render(@code_lesson.lesson_content).html_safe
    @cl_instructions = markdown.render(@code_lesson.instructions).html_safe
    @cl_hints = markdown.render(@code_lesson.hints).html_safe
  end
end
