class AddUserDeets < ActiveRecord::Migration
  def self.up
    add_column :users, :time_zone, :string
    add_column :users, :date_format, :string
    add_column :users, :time_format, :string
    add_column :users, :update_twitter_status, :boolean
  end

  def self.down
    remove_column :users, :update_twitter_status
    remove_column :users, :time_format
    remove_column :users, :date_format
    remove_column :users, :time_zone
  end
end
