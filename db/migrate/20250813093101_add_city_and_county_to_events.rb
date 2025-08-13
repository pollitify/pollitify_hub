class AddCityAndCountyToEvents < ActiveRecord::Migration[8.0]
  def change
    add_reference :events, :city, foreign_key: true, null: true
    add_reference :events, :county, foreign_key: true, null: true
  end
end
