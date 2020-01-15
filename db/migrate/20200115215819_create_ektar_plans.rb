class CreateEktarPlans < ActiveRecord::Migration[6.0]
  def change
    create_table :ektar_plans do |t|
      t.string :name, null: false
      t.boolean :free, null: false, default: false
      t.integer :trial, null: false, default: 0
      t.integer :price, null: false, default: 0
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
