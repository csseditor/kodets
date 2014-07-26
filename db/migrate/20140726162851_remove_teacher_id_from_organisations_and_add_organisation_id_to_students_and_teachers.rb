class RemoveTeacherIdFromOrganisationsAndAddOrganisationIdToStudentsAndTeachers < ActiveRecord::Migration
  def change
    remove_column :organisations, :teacher_id
    add_column :teachers, :organisation_id, :integer
  end
end
