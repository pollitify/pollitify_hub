class CreateFeatures < ActiveRecord::Migration[8.0]
  def change
    create_table :features do |t|
      t.string :name
      t.string :fid
      t.references :feature_category
      t.text :description
      t.timestamps
    end
  end
end
