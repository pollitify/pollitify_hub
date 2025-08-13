class LoosenForeignKeySettingsForEvents < ActiveRecord::Migration[8.0]
  def change
    change_column_null :events, :organization_id, true
    change_column_null :events, :congressional_district_id, true
    change_column_null :events, :event_type_id, true
    
  end
end
