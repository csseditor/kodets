class AddAdditionalFieldsToOrganisations < ActiveRecord::Migration
  def change
    add_column :organisations, :name, :string
    add_column :organisations, :username, :string
    add_column :organisations, :url, :string
  end
end
