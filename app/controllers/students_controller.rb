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

  def import_view
    @student = Student.new
  end

  def import
    begin
      raise Exceptions::NoFileGiven, 'No file was provided' unless params[:file]
      spreadsheet = open_spreadsheet params[:file]
      header = spreadsheet.row 1
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        student = Student.find_by_email(row["email"]) || Student.new
        student.attributes = row.to_hash.merge({
          organisation_id: current_org.id,
          password_confirmation: row["password"]
        })
        student.save!
      end

      flash[:success] = 'Students added to Organisation.'
      redirect_to import_students_view_path
    rescue Exceptions::MaximumPopulationReached => e
      flash[:warning] = e.message
      redirect_to import_students_view_path
    rescue Exceptions::NoFileGiven => e
      flash[:warning] = e.message
      redirect_to import_students_view_path
    rescue => e
      flash[:warning] = e.message
      redirect_to import_students_view_path
    end
  end

  private

  def open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def teacher_user
    unless current_teacher
      flash[:notice] = 'You do not have the correct permissions to access this page.'
      redirect_to root_path
    end
  end
end
