class AddAdditionalFieldsToEvents < ActiveRecord::Migration[8.0]
  def change
    #County,City,Date,Time (Local),Event Name,Location,Group,"Type (protest, town hall, ect.)",Notes/Info,
    add_column :events, :county, :string
    add_column :events, :location, :string
    add_column :events, :organizing_group, :string
    add_column :events, :event_type_name, :string
    add_column :events, :notes, :string
    add_column :events, :date_start_at, :date
    add_column :events, :time_start_at, :time
    add_column :events, :time_end_at, :time
  end
end