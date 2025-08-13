class AddUSerFieldsToOrganization < ActiveRecord::Migration[8.0]
  def change
    add_column :organizations, :first_name, :string
    add_column :organizations, :last_name, :string
    add_column :organizations, :email, :string
    add_column :organizations, :username, :string
    add_column :organizations, :password, :string
  end
end
