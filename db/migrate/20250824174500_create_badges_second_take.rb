class CreateBadgesSecondTake < ActiveRecord::Migration[8.0]
  def change
    drop_table :user_badges
    drop_table :badges
    create_table :badges do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :icon, null: false
      t.string :color, null: false
      t.integer :category, null: false, default: 0, null: false
      t.integer :requirement_type, null: false, default: 0, null: false
      t.integer :requirement_value, null: false
      t.boolean :active, default: true

      t.timestamps
    end
    
    add_index :badges, :name, unique: true
    add_index :badges, :category
    add_index :badges, :active
  end
end
