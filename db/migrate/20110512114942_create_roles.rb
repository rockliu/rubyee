class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.column :name,:string
    end
    Role.create(:name => "管理员")
  end

  def self.down
    drop_table :roles
  end
end
