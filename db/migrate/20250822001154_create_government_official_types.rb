class CreateGovernmentOfficialTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :government_official_types do |t|
      t.string :name
      t.string :fid
      t.timestamps
    end
  end
end
