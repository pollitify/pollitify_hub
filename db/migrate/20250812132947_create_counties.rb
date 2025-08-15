class CreateCounties < ActiveRecord::Migration[8.0]
  def change
    drop_table :counties, if_exists: true
    create_table :counties do |t|
      t.string :name
      t.string :name_ascii
      t.string :name_full
      t.string :county_fips
      t.references :state, null: false, foreign_key: true
      t.string :state_abbreviation
      t.string :state_name
      t.decimal :lat, precision: 10, scale: 6
      t.decimal :lng, precision: 10, scale: 6
      #t.st_point :coordinates, geographic: true, has_z: false
      t.integer :population

      t.timestamps
    end
  end
end
