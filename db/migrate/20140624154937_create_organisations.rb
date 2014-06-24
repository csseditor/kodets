class CreateOrganisations < ActiveRecord::Migration
  def change
    create_table :organisations do |t|
      t.string :name, default: ""
      t.string :ref,  default: ""
      t.string :url,  default: ""

      t.timestamps
    end
  end
end
