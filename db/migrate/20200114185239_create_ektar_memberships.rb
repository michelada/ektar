# typed: true
class CreateEktarMemberships < ActiveRecord::Migration[6.0]
  def change
    create_table :ektar_memberships do |t|
      t.references :ektar_organization, null: false, foreign_key: true
      t.references :ektar_user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
