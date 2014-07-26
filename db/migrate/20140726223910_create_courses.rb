class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name, default: ""
      t.text :description, default: ""
      t.integer :organisation_id
      t.string :colour, default: "#4589E3"

      t.timestamps
    end
  end
end
