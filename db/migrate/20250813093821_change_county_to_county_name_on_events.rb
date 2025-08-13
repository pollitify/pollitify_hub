class ChangeCountyToCountyNameOnEvents < ActiveRecord::Migration[8.0]
  def change
    rename_column :events, :county, :county_name    
  end
end
