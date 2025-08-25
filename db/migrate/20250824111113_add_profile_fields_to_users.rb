class AddProfileFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :bio, :text
    add_column :users, :location, :string
    add_column :users, :political_interests, :text
    add_column :users, :public_profile, :boolean
  end
end
