class AddUserFields < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :twitter_username, :string
    remove_column :users, :name
    remove_column :users, :update_twitter_status
  end

  def self.down
    add_column :users, :name, :string
    add_column :users, :update_twitter_status, :boolean
    remove_column :table_name, :column_name
    remove_column :users, :twitter_username
    remove_column :users, :last_name
    remove_column :users, :first_name
  end
end
