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

    # Runs user code
    @sandie = Sandie.new(language: Language.find(@cl.language_id).code_eval_slug)
    @code = @sandie.evaluate(code: params[:user_code])

    # Evaluates user code against corectness tests
    @test = evaluate_code_against_tests(params[:user_code],
                                        @code['stdout'],
                                        @cl.correctness_test)

    # make_progress(params[:user_id], params[:organisation_id],
    #               params[:lesson_id], params[:item_type], params[:track_id],
    #               params[:user_code], params[:user_code])

    # Returns the result of the evaluation and the result of the correctness tests.
    render json: @code.merge(@test).to_json.inspect
  end

  def save_progress

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
                                       space_after_headers: true,
                                       fenced_code_blocks: true,
                                       prettify: true)

    @cl_lesson_content = markdown.render(@code_lesson.lesson_content).html_safe
    @cl_instructions = markdown.render(@code_lesson.instructions).html_safe
    @cl_hints = markdown.render(@code_lesson.hints).html_safe
  end

  def make_progress(user_id, org_id, item_id, item_type, track_id, user_code)
    # @progress = Progress.where(user_id: user_id,
    #                            item_id: item_id,
    #                            item_type: item_type,
    #                            track_id: track_id,
    #                            organisation_id: org_id).first_or_create
    # @progress.update_attributes(content: user_code,
    #                             attempts: @progress.attempts + 1)
  end

  def evaluate_code_against_tests(user_code, result, tests)
    {
      pass: Sandie.new(language: 'ruby').evaluate(
        code: <<-EVAL
          code = %Q{#{user_code.to_s}}
          result = %Q{#{result.to_s}}
          puts #{tests}
        EVAL
      )['stdout']
    }
  end
end
