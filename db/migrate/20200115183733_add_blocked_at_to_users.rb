# typed: true
class AddBlockedAtToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :ektar_users, :blocked_at, :timestamp
  end
end
