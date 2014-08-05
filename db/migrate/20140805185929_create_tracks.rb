class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name
      t.text :description, default: ""
      t.integer :course_id
      t.integer :order

      t.timestamps
    end
  end
end
