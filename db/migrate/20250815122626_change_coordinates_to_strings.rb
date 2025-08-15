class ChangeCoordinatesToStrings < ActiveRecord::Migration[8.0]
  def change
    if Rails.env.development?
      change_column :cities, :coordinates, :string
      change_column :counties, :coordinates, :string
    end
  end
end