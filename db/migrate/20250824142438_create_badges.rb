class CreateBadges < ActiveRecord::Migration[8.0]
  def change
    create_table :badges do |t|
      t.string :name
      t.text :description
      t.string :icon
      t.string :color
      t.string :category
      t.string :requirement_type
      t.integer :requirement_value
      t.boolean :active

      t.timestamps
    end
  end
end
