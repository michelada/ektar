class AddUuidToUsers < ActiveRecord::Migration[6.0]
  def change
    enable_extension "uuid-ossp"
    add_column :ektar_users, :global_id, :uuid, default: "uuid_generate_v4()", null: false

    add_index :ektar_users, :global_id, unique: true
  end
end
