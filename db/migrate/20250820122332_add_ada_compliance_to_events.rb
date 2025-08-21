class AddAdaComplianceToEvents < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :ada_accessible, :boolean
  end
end