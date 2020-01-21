# typed: true
class AddActiveToMembership < ActiveRecord::Migration[6.0]
  def change
    add_column :ektar_memberships, :active, :boolean, default: true, null: false
  end
end
