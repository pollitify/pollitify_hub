class CreateAchievements < ActiveRecord::Migration[8.0]
  def change
    create_table :achievements do |t|
      t.references :user, foreign_key: true
      t.string :achievement_type
      t.integer :milestone_value
      t.datetime :achieved_at

      t.timestamps
    end
  end
end
