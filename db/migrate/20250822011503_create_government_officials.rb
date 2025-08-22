class CreateGovernmentOfficials < ActiveRecord::Migration[8.0]
  def change
    create_table :government_officials do |t|
      t.string :full_name
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :title
      t.string :phone_number
      t.string :email_link
      t.string :full_address
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state_name
      t.string :zip
      t.references :state, foreign_key: true
      t.references :government_official_type, foreign_key: true
      t.text :committees
      t.boolean :veteran, default: false
      t.references :political_party, foreign_key: true
      t.references :congressional_district, foreign_key: true
      t.string :suffix
      t.string :nickname
      t.date :birthday
      t.string :gender
      t.string :job_type
      t.string :district
      t.string :senate_class
      t.string :party
      t.string :url
      t.string :address
      t.string :phone
      t.string :contact_form
      t.string :rss_url
      t.string :twitter
      t.string :twitter_id
      t.string :facebook
      t.string :youtube
      t.string :youtube_id
      t.string :mastodon
      t.string :bluesky
      t.string :bluesky_id
      t.string :bioguide_id
      t.string :thomas_id
      t.string :opensecrets_id
      t.string :lis_id
      t.string :fec_ids
      t.string :cspan_id
      t.string :govtrack_id
      t.string :votesmart_id
      t.string :ballotpedia_id
      t.string :washington_post_id
      t.string :icpsr_id
      t.string :wikipedia_id

      t.timestamps
    end
  end
end
