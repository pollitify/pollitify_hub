class CreateCongressionalDistricts < ActiveRecord::Migration[8.0]
  def change
    create_table :congressional_districts do |t|
      t.string :name
      t.string :key_city
      t.string :key_county
      t.references :state, null: false, foreign_key: true
      t.timestamps
    end
  end
end
