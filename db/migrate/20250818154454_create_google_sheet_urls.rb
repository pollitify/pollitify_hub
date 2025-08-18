class CreateGoogleSheetUrls < ActiveRecord::Migration[8.0]
  def change
    create_table :google_sheet_urls do |t|
      t.string :name
      t.string :url
      t.text :options
      t.datetime :last_checked_at
      t.string :ip_address
      t.string :user_agent
      t.references :user, foreign_key: true, null: true

      t.timestamps
    end
  end
end
