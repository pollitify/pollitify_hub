class CreateCongressionalDistrictTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :congressional_district_types do |t|
      t.string :name
      t.string :fid

      t.timestamps
    end
  end
end
