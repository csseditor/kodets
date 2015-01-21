class AddTimeCompletedToProgresses < ActiveRecord::Migration
  def change
    add_column :progresses, :time_completed, :datetime
  end
end
