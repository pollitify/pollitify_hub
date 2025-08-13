class AddOriginalDataToEvents < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :source_data, :text
  end
end
