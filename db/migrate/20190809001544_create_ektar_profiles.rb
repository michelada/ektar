# typed: true
class CreateEktarProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :ektar_profiles do |t|
      t.string :name, null: false
      t.belongs_to :ektar_user, foreign_key: true

      t.timestamps
    end

    add_index(:ektar_profiles, :name, unique: true)
  end
end
