class AddStateFieldsToGovernmentOfficials < ActiveRecord::Migration[8.0]
  def change
    add_column :government_officials, :fid, :string
    add_column :government_officials, :current_chamber, :string
    add_column :government_officials, :email, :string
    add_column :government_officials, :biography, :text
    add_column :government_officials, :death_date, :date
    add_column :government_officials, :image, :string
    add_column :government_officials, :links, :jsonb, default: [], null: true
    add_column :government_officials, :sources, :jsonb, default: [], null: true
    add_column :government_officials, :capitol_voice, :string
    add_column :government_officials, :capitol_fax, :string
    add_column :government_officials, :district_address, :string
    add_column :government_officials, :district_voice, :string
    add_column :government_officials, :district_fax, :string
    add_column :government_officials, :instagram, :string
    add_column :government_officials, :wikidata, :string
    add_column :government_officials, :home_address1, :string
    add_column :government_officials, :home_address2, :string
    add_column :government_officials, :home_city, :string
    add_column :government_officials, :home_state, :string
    add_column :government_officials, :home_zip, :string
    add_column :government_officials, :home_phone, :string
  end
end