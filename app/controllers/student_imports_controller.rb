class StudentImportsController < ApplicationController

  def new
    @student_import = StudentImport.new
  end

  def create
    begin
      @student_import = StudentImport.new(params[:student_import].merge({ current_org: current_org }))
      saved = @student_import.save
    rescue Exceptions::MaximumPopulationReached => e
      flash[:warning] = e.message
      redirect_to new_student_import_path
    rescue Exceptions::NoFileGiven => e
      flash[:warning] = e.message
      redirect_to new_student_import_path
    rescue => e
      flash[:warning] = e.class.to_s + ': ' + e.message
      redirect_to new_student_import_path
    else
      if saved
        flash[:notice] = 'Students imported successfully!'
        redirect_to students_path
      else
        render :new
      end
    end
  end
end
