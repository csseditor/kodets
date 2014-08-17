class CreateCodeLessons < ActiveRecord::Migration
  def change
    create_table :code_lessons do |t|
      t.string :name
      t.text :lesson_content, default: ""
      t.text :instructions,   default: ""
      t.text :hints,          default: ""
      t.text :starting_code
      t.integer :language_id
      t.integer :order
      t.integer :track_id
      t.integer :user_id
      t.boolean :visible,   default: false
      t.boolean :shareable, default: false
      t.integer :organisation_id
      t.datetime :date_due
      t.text :correctness_test

      t.timestamps
    end
  end
end
