class AddCountyToCity < ActiveRecord::Migration[8.0]
  def change
    add_reference :cities, :county, null: true, foreign_key: true
  end
end
