class StudentImport
  # A class which impoersonates a model to allow students to be imported without
  # being database-driven
  include ActiveModel::Model

  attr_accessor :file
  attr_accessor :current_org

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def save
    if imported_students.map(&:valid?).all?
      imported_students.each(&:save!)
      true
    else
      imported_students.each_with_index do |product, index|
        product.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def imported_students
    @imported_students ||= load_imported_students
  end

  def load_imported_students
    raise Exceptions::NoFileGiven, 'No file was provided' unless file
    spreadsheet = open_spreadsheet
    header = spreadsheet.row 1
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      student = Student.find_by_email(row["email"]) || Student.new
      student.attributes = row.to_hash.merge({
        organisation_id: current_org.id,
        password_confirmation: row["password"]
      })
      student
    end
  end

  def open_spreadsheet
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
