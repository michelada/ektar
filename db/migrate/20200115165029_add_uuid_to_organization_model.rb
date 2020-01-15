class AddUuidToOrganizationModel < ActiveRecord::Migration[6.0]
  def change
    enable_extension "uuid-ossp"
    add_column :ektar_organizations, :global_id, :uuid, default: "uuid_generate_v4()", null: false

    add_index :ektar_organizations, :global_id, unique: true
  end
end
