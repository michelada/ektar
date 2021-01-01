# typed: ignore
class RailsFrameworks < ActiveRecord::Migration[6.0]
  create_table :active_storage_blobs, if_not_exists: true do |t|
    t.string :key, null: false
    t.string :filename, null: false
    t.string :content_type
    t.text :metadata
    t.bigint :byte_size, null: false
    t.string :checksum, null: false
    t.datetime :created_at, null: false

    t.index [:key], unique: true unless index_exists?(:active_storage_blobs, :key)
  end

  create_table :active_storage_attachments, if_not_exists: true do |t|
    t.string :name, null: false
    t.references :record, null: false, polymorphic: true, index: false
    t.references :blob, null: false unless index_exists?(:active_storage_attachments, :blob_id)

    t.datetime :created_at, null: false

    t.index [:record_type, :record_id, :name, :blob_id], name: "index_active_storage_attachments_uniqueness", unique: true unless index_exists?(:active_storage_attachments, [:record_type, :record_id, :name, :blob_id], name: "index_active_storage_attachments_uniqueness")
    t.foreign_key :active_storage_blobs, column: :blob_id unless foreign_key_exists?(:active_storage_attachments, :blob_id)
  end

  create_table :action_text_rich_texts, if_not_exists: true do |t|
    t.string :name, null: false
    t.text :body, size: :long
    t.references :record, null: false, polymorphic: true, index: false unless index_exists?(:action_text_rich_texts, :record_id)

    t.timestamps

    t.index [:record_type, :record_id, :name], name: "index_action_text_rich_texts_uniqueness", unique: true unless index_exists?(:action_text_rich_texts, [:record_type, :record_id, :name], name: "index_action_text_rich_texts_uniqueness")
  end
end
