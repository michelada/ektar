# typed: true
class AsociatePlansWithOrganization < ActiveRecord::Migration[6.0]
  def change
    change_table :ektar_organizations do |t|
      t.belongs_to :ektar_plan
    end
  end
end
