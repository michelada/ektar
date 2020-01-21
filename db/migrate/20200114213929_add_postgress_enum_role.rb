# typed: false
class AddPostgressEnumRole < ActiveRecord::Migration[6.0]
  def change
    create_enum :role, %w(admin member)

    change_table :ektar_memberships do |t|
      t.enum :role, enum_name: :role, default: "member", null: false
    end
  end
end
