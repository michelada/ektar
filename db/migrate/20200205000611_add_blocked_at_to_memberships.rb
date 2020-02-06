# typed: true
class AddBlockedAtToMemberships < ActiveRecord::Migration[6.0]
  def change
    add_column :ektar_memberships, :blocked_at, :timestamp
  end
end
