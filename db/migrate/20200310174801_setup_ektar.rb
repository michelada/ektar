class SetupEktar < ActiveRecord::Migration[6.0]
  def change
    enable_extension "uuid-ossp"

    create_table :ektar_plans do |t|
      t.string :name, null: false
      t.boolean :free, null: false, default: false
      t.integer :trial, null: false, default: 0
      t.boolean :active, null: false, default: true
      t.monetize :price

      t.timestamps
    end

    create_table :ektar_organizations do |t|
      t.string :name, null: false
      t.boolean :enable, default: true
      t.uuid :global_id, default: "uuid_generate_v4()", null: false
      t.belongs_to :ektar_plan

      t.timestamps
    end
    add_index :ektar_organizations, :name, unique: true
    add_index :ektar_organizations, :global_id, unique: true

    create_table :ektar_users do |t|
      t.string :email, null: false
      t.belongs_to :ektar_organization, foreign_key: true
      t.boolean :super_admin, default: false
      t.timestamp :blocked_at
      t.string :password_digest, null: false
      t.string :recovery_password_digest
      t.timestamp :last_activity_at
      t.string :last_ip
      t.uuid :global_id, default: "uuid_generate_v4()", null: false

      t.timestamps
    end
    add_index :ektar_users, :email, unique: true
    add_index :ektar_users, :global_id, unique: true

    create_table :active_storage_blobs do |t|
      t.string :key, null: false
      t.string :filename, null: false
      t.string :content_type
      t.text :metadata
      t.bigint :byte_size, null: false
      t.string :checksum, null: false
      t.datetime :created_at, null: false

      t.index [:key], unique: true
    end

    create_table :active_storage_attachments do |t|
      t.string :name, null: false
      t.references :record, null: false, polymorphic: true, index: false
      t.references :blob, null: false

      t.datetime :created_at, null: false

      t.index [:record_type, :record_id, :name, :blob_id], name: "index_active_storage_attachments_uniqueness", unique: true
      t.foreign_key :active_storage_blobs, column: :blob_id
    end

    create_table :ektar_memberships do |t|
      t.references :ektar_organization, null: false, foreign_key: true
      t.references :ektar_user, null: false, foreign_key: true
      t.boolean :active, default: true, null: false
      t.boolean :owner, null: false, default: false
      t.timestamp :blocked_at

      t.timestamps
    end

    create_enum :role, %w(admin member)
    change_table :ektar_memberships do |t|
      t.enum :role, enum_name: :role, default: "member", null: false
    end

    create_table :action_text_rich_texts do |t|
      t.string     :name, null: false
      t.text       :body, size: :long
      t.references :record, null: false, polymorphic: true, index: false

      t.timestamps

      t.index [ :record_type, :record_id, :name ], name: "index_action_text_rich_texts_uniqueness", unique: true
    end

    create_table :ektar_used_passwords do |t|
      t.references :ektar_user, null: false, foreign_key: true
      t.string :password_digest, null: false

      t.timestamps
    end

    create_table :ektar_invitations do |t|
      t.string :invitation_token
      t.timestamp :invitation_accepted_at
      t.string :email, null: false
      t.references :ektar_organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
