class RemoveIdFromCategoriesTags < ActiveRecord::Migration
  def self.up
    remove_column :categories_tags, :id
  end

  def self.down
    add_column :categories_tags, :id, :integer
  end
end
