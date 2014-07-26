class AddUsernameToStudents < ActiveRecord::Migration
  def change
    add_column :students, :username, :string
    add_index :students, :username, unique: true
  end
end
