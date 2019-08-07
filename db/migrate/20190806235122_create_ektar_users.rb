class CreateEktarUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :ektar_users do |t|
      t.string :email, null: false
      t.string :encrypted_password, null: false
      t.integer :role, default: 1
      t.belongs_to :ektar_organizations, foreign_key: true

      t.timestamps
    end

    add_index(:ektar_users, :email, unique: true)
  end
end
