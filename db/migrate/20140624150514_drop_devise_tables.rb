class DropDeviseTables < ActiveRecord::Migration
  def change
    drop_table :users
    drop_table :organisations
  end
end
