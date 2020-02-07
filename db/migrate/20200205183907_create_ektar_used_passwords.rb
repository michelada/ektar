# typed: true
class CreateEktarUsedPasswords < ActiveRecord::Migration[6.0]
  def change
    create_table :ektar_used_passwords do |t|
      t.references :ektar_user, null: false, foreign_key: true
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
