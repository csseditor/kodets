class StudentsController < ApplicationController
  def new
  end

  def edit
  end

  def index
    @students = Student.all
  end

  def import
    @student = Student.new
    #Student.import params[:file]

    begin
      spreadsheet = open_spreadsheet params[:file]
      header = spreadsheet.row 1
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        student = Student.find_by_email(row["email"]) || Student.new
        student.attributes = row.to_hash.merge({ organisation_id: current_org.id })
        student.save!
      end

      flash[:success] = 'Students added to Organisation.'
      redirect_to import_students_view_path
    rescue Exceptions::MaximumPopulationReached => e
      flash[:warning] = e.message
      redirect_to import_students_view_path
    rescue => e
      flash[:warning] = e.message
      redirect_to import_students_view_path
    end
  end

  def import_view
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
end
