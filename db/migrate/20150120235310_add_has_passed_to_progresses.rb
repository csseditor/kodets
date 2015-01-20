class AddHasPassedToProgresses < ActiveRecord::Migration
  def change
    add_column :progresses, :has_passed, :boolean, default: false
  end
end
