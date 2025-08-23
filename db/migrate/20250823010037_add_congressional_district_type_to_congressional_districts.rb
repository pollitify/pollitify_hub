class AddCongressionalDistrictTypeToCongressionalDistricts < ActiveRecord::Migration[8.0]
  def change
    add_reference :congressional_districts, :congressional_district_type, foreign_key: true
  end
end
