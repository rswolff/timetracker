class AddCategoriesTagsTable < ActiveRecord::Migration
  def self.up
    create_table :categories_tags, :force => true do |t|
      t.integer :category_id
      t.integer :tag_id
      t.timestamps
    end
  end

  def self.down
    drop_table :categories_tags
  end
end
