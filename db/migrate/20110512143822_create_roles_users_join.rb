class CreateRolesUsersJoin < ActiveRecord::Migration
  def self.up
    create_table :roles_users,:id => false do |t|
      t.column :role_id,:integer,:null=>false
      t.column :user_id,:integer,:null=>false
    end
    admin_user = User.create(:username => "admin",
                             :email => "admin@rubyee.net",
                             :profile => "站点管理员",
                             :password => "admin",
                             :password_confirmation => "admin")
    admin_role = Role.find_by_name("管理员")
    admin_user.roles << admin_role
  end

  def self.down
    drop_table :roles_users
    User.find_by_username("admin").destroy
  end
end
