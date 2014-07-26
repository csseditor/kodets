class FixUniquenessValidationOnStudentsUsernames < ActiveRecord::Migration
  def change
    remove_index :students, :username
    add_index :students, [:username, :organisation_id], unique: true
  end
end
