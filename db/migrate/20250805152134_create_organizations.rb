class CreateOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :fid
      t.boolean :active, default: true
      t.references :secure_chat_system, null: false, foreign_key: true
      t.string :billing
      t.string :city
      t.references :state
      t.string :organization_website_url
      t.string :organization_website_domain
      t.string :your_domain_or_ours
      t.references :domain, null: false, foreign_key: true
      t.string :sub_domain
      t.string :polly_domain
      t.string :polly_url
      t.text :features
      t.timestamps
    end
  end
end
