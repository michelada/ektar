# typed: true
class AddSuperadminToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :ektar_users, :superadmin, :boolean, default: false
    remove_column :ektar_users, :role
  end
end
