class AddOrganisationRefToUsers < ActiveRecord::Migration
  def change
    add_column :users, :organisation_ref, :string, default: ""
  end
end
