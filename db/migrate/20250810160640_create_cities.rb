class CreateCities < ActiveRecord::Migration[8.0]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :fid
      t.string :name_ascii
      t.string :state_fid
      t.string :state_name
      t.integer :county_fips
      t.string :county_name
      t.decimal :lat, precision: 10, scale: 6
      t.decimal :lng, precision: 10, scale: 6
      t.st_point :coordinates, geographic: true, has_z: false
      t.integer :population
      t.decimal :density
      t.string :source
      t.boolean :military
      t.boolean :incorporated
      t.string :timezone
      t.integer :ranking
      t.integer :external_fid
      t.references :state, null: false, foreign_key: true
      t.text :zips

      t.timestamps
    end
  end
end
