class ChangeBadgeCategoryToInteger < ActiveRecord::Migration[8.0]
  def change
    remove_column :badges, :category
    add_column :badges, :category, :integer, default: 0, null: false
    remove_column :badges, :requirement_type
    add_column :badges, :requirement_type, :integer, default: 0, null: false
  end
end
