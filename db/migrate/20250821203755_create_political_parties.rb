class CreatePoliticalParties < ActiveRecord::Migration[8.0]
  def change
    create_table :political_parties do |t|
      t.string :name
      t.string :fid
      t.string :url
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
