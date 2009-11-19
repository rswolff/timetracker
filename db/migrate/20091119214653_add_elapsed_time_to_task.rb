class AddElapsedTimeToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :elapsed_time_in_seconds, :integer
  end

  def self.down
    remove_column :tasks, :elapsed_time_in_seconds
  end
end
