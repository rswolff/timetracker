class AddNotTaggedToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :not_tagged, :boolean
  end

  def self.down
    remove_column :tasks, :not_tagged
  end
end
