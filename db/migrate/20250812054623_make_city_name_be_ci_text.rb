class MakeCityNameBeCiText < ActiveRecord::Migration[8.0]
  def change
    change_column :events, :city, :citext
    change_column :events, :county, :citext
  end
end
