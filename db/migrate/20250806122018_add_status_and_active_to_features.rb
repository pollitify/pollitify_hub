class AddStatusAndActiveToFeatures < ActiveRecord::Migration[8.0]
  def change
    add_column :features, :status, :string
    add_column :features, :active, :boolean, default: true
  end
end
