class CodeLessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_teacher!, only: :submission

  layout 'code_lesson', only: [:show, :submission]

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
    @progress = Progress.where(lesson_id: @code_lesson.id,
                               lesson_type: 'CodeLesson',
                               user_id: current_user.id)

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

    @progresses = @code_lesson.progresses
  end

  def submission
    @code_lesson = CodeLesson.find params[:code_lesson_id]
    @progress = Progress.find params[:progress_id]
    @language = @code_lesson.language
    @creator = User.find @code_lesson.user_id
    @track = @code_lesson.track
  end

  def run_code
    @cl = CodeLesson.find(params[:lesson_id])

    # Runs user code
    @sandie = Sandie.new(language: Language.find(@cl.language_id).code_eval_slug)
    @code = @sandie.evaluate(code: params[:user_code])

    # Evaluates user code against corectness tests
    @test = evaluate_code_against_tests(params[:user_code],
                                        @code['stdout'],
                                        @cl.correctness_test)

    result = @code[:stderr] == nil && @test[:pass] == "true\n"

    render json: @code.merge({ pass: result }).to_json.inspect
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

    result = @code[:stderr] == nil && @test[:pass] == "true\n"

    # Save the code the user has submitted to database
    make_progress(params[:user_id], params[:organisation_id],
                  params[:lesson_id], params[:lesson_type], params[:user_code],
                  result)

    # Returns the result of the evaluation and the result of the correctness tests.
    render json: @code.merge({ pass: result }).to_json.inspect
  end

  def save_progress

  end

  private

  def code_lesson_params
    params.require(:code_lesson).permit(:name, :language_id, :lesson_content,
                                        :starting_code, :instructions, :hints,
                                        :order, :user_id, :organisation_id,
                                        :date_due, :correctness_test)
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

  def make_progress(user_id, org_id, lesson_id, lesson_type, user_code, result)
    @progress = Progress.where(user_id: user_id,
                               lesson_id: lesson_id,
                               lesson_type: lesson_type,
                               organisation_id: org_id).first_or_create
    if @progress.has_passed
      @progress.update_attributes(content: user_code)
    elsif result
      @progress.update_attributes(content: user_code,
                                  number_of_attempts: @progress.number_of_attempts + 1,
                                  has_passed: result,
                                  time_completed: Time.now)
    else
      @progress.update_attributes(content: user_code,
                                  number_of_attempts: @progress.number_of_attempts + 1,
                                  has_passed: result)
    end
  end

  def evaluate_code_against_tests(user_code, result, tests)
    tests = tests == "" ? true : tests
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
