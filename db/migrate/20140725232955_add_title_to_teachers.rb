class AddTitleToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :title, :string, default: ""
  end
end
