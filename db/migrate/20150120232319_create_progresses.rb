class CreateProgresses < ActiveRecord::Migration
  def change
    create_table :progresses do |t|
      t.integer :user_id
      t.integer :lesson_id
      t.string :lesson_type
      t.text :content
      t.integer :organisation_id
      t.integer :number_of_attempts, default: 0

      t.timestamps
    end
  end
end
