# typed: true
class RemaneColumnOnUsersTable < ActiveRecord::Migration[6.0]
  def change
    rename_column :ektar_users, :superadmin, :super_admin
  end
end
