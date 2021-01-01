# typed: ignore
class AddResetPasswordTokenToEktarUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :ektar_users, :reset_password_token, :string
  end
end
