class CreateUserBadgesSecondTake < ActiveRecord::Migration[8.0]
  def change
    #drop_table :user_badges
    create_table :user_badges do |t|
      t.references :user, null: false, foreign_key: true
      t.references :badge, null: false, foreign_key: true
      t.datetime :earned_at, null: false
      t.integer :points_earned, default: 0
      t.json :verification_data

      t.timestamps
    end
  
    add_index :user_badges, [:user_id, :badge_id], unique: true
    add_index :user_badges, :earned_at
  end
end
