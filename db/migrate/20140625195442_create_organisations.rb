class CreateOrganisations < ActiveRecord::Migration
  def change
    create_table :organisations do |t|
      t.integer :ref
      t.string :name
      t.string :email
      t.text :description
      t.string :url
      t.string :location
      t.references :teacher, index: true
      t.references :student, index: true

      t.timestamps
    end

    add_index :organisations, :ref, unique: true
  end
end
