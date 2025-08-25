class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.text :content
      t.integer :post_type
      t.boolean :verified
      t.integer :points_earned
      t.datetime :activity_date
      t.string :location

      t.timestamps
    end
  end
end
