class AddDataSourceToGovernmentOfficials < ActiveRecord::Migration[8.0]
  def change
    add_column :government_officials, :data_source, :string
  end
end
