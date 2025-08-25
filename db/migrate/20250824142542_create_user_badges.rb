class CreateUserBadges < ActiveRecord::Migration[8.0]
  def change
    create_table :user_badges do |t|
      t.references :user, foreign_key: true
      t.references :badge, foreign_key: true
      t.datetime :earned_at
      t.integer :points_earned
      t.json :verification_data

      t.timestamps
    end
  end
end
