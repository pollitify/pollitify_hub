class AddMyLocationFieldsToUser < ActiveRecord::Migration[8.0]
  def change
    add_reference :users, :state, foreign_key: true, null: true
    add_reference :users, :county, foreign_key: true, null: true
    add_reference :users, :city, foreign_key: true, null: true
  end
end
