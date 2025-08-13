class CreateFeatureCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :feature_categories do |t|
      t.string :name
      t.string :fid
      t.timestamps
    end
  end
end
