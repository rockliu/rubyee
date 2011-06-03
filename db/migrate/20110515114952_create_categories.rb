class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.column :name,:string
    end
    new_category = Category.create(:name => '站点新闻')
    change_column :articles,:category_id,:integer,:default => new_category
  end

  def self.down
    change_column :articles,:category_id,:integer,:default => 0
    drop_table :categories
  end
end
