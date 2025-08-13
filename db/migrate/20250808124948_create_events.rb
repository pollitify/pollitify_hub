class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.string :name
      t.references :event_type, null: false, foreign_key: true
      t.datetime :event_start_at
      t.datetime :event_end_at
      t.string :address1
      t.string :address2
      t.string :city
      t.references :state, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true
      t.string :organization_fid
      t.string :slug
      t.string :fid
      t.references :congressional_district, null: false, foreign_key: true
      t.boolean :recurring, default: false
      t.text :recurrence
      t.string :url
      t.string :mobilize_url
      t.boolean :is_suggested_event
      t.text :pasted_description

      t.timestamps
    end
    add_index :events, [:state_id, :city, :event_start_at]
    #add_index :events, [:state, :city, :event_start_at]
  end
end