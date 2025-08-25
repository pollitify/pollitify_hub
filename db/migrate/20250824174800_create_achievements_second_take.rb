class CreateAchievementsSecondTake < ActiveRecord::Migration[8.0]
  def change
    drop_table :achievements
    create_table :achievements do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :achievement_type, null: false, default: 0, null: false
      t.integer :milestone_value, null: false
      t.datetime :achieved_at, null: false

      t.timestamps
    end
    
    add_index :achievements, [:user_id, :achievement_type, :milestone_value], 
              unique: true, name: 'index_achievements_on_user_type_milestone'
    add_index :achievements, :achieved_at
  end
end
