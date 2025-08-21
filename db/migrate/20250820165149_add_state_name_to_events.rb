class AddStateNameToEvents < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :state_name, :string
  end
end
