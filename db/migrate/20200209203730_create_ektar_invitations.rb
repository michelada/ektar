class CreateEktarInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :ektar_invitations do |t|
      t.string :invitation_token
      t.timestamp :invitation_accepted_at
      t.references :ektar_organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
