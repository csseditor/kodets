class AddMaxUsersToOrganisations < ActiveRecord::Migration
  def change
    add_column :organisations, :max_users, :integer
  end
end
