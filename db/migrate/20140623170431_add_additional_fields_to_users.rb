class AddAdditionalFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :bio, :text
    add_column :users, :teacher, :boolean, default: false
    add_column :users, :organisation_id, :integer
  end
end
