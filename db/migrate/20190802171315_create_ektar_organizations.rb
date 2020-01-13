# typed: true
class CreateEktarOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :ektar_organizations do |t|
      t.string :name, null: false
      t.boolean :enable, default: true

      t.timestamps
    end

    add_index(:ektar_organizations, :name, unique: true)
  end
end
