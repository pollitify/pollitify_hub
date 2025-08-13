class AddZipsToCounty < ActiveRecord::Migration[8.0]
  def change
    add_column :counties, :zips, :text
  end
end
