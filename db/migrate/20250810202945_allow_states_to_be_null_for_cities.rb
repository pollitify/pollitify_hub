class AllowStatesToBeNullForCities < ActiveRecord::Migration[8.0]
  def change
    change_column_null :cities, :state_id, true
  end
end
