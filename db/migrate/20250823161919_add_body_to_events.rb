class AddBodyToEvents < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :body, :text
  end
end
