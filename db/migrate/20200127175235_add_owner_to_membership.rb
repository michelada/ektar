class AddOwnerToMembership < ActiveRecord::Migration[6.0]
  def change
    add_column :ektar_memberships, :owner, :boolean, null: false,  default: false
  end
end
