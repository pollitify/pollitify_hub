class ChangeCityToCityNameOnEvents < ActiveRecord::Migration[8.0]
  def change
    rename_column :events, :city, :city_name    
    
  end
end
