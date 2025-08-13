class CreateStates < ActiveRecord::Migration[8.0]
  def change
    create_table :states do |t|
      t.string :name
      t.string :abbreviation
      t.string :fid
      t.integer :population
      t.integer :congressional_district_count
      t.string :wikipedia_congressional_district_url
      t.string :wikipedia_congressional_district_map_url
      t.integer :counties_count
      t.string :townships_count

      t.timestamps
    end
  end
end
