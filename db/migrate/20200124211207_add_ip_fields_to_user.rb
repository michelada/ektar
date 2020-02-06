# typed: true
class AddIpFieldsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :ektar_users, :last_activity_at, :timestamp
    add_column :ektar_users, :last_ip, :string
  end
end
