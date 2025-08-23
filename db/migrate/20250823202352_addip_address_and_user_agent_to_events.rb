class AddipAddressAndUserAgentToEvents < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :ip_address, :string
    add_column :events, :user_agent, :string
  end
end