class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.column :title, :string
      t.column :permalink, :string
      t.column :body, :text
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
 Page.create(:title =>"RubyEE 主页",
	          :permalink => "欢迎页面",
	          :body => "欢迎来到ruby爱好者！")
  end

  def self.down
    drop_table :pages
  end
end
