class AddInvitationFieldsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :ektar_users, :invitation_created_at, :timestamp, default: nil
    add_column :ektar_users, :invitation_accepted_at, :timestamp, default: nil
    add_column :ektar_users, :invitation_token, :string
  end
end
