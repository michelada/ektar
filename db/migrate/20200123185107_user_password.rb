# typed: true
class UserPassword < ActiveRecord::Migration[6.0]
  def change
    remove_column :ektar_users, :encrypted_password
    add_column :ektar_users, :password_digest, :string, null: false
    add_column :ektar_users, :recovery_password_digest, :string
  end
end
