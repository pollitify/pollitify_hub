class CreateSecureChatSystems < ActiveRecord::Migration[8.0]
  def change
    create_table :secure_chat_systems do |t|
      t.string :name
      t.string :fid
      t.string :url
      t.string :icon_url
      t.text :description

      t.timestamps
    end
  end
end
