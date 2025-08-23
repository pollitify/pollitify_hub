class ChangeUserLevelCongressionalDistricts < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :congressional_district_id
    
    add_reference :users, :federal_congressional_district,
                     foreign_key: { to_table: :congressional_districts },
                     index: true
                     
    add_reference :users, :state_congressional_district,
                    foreign_key: { to_table: :congressional_districts },
                    index: true
  end
end