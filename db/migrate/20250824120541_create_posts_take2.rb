class CreatePostsTake2 < ActiveRecord::Migration[8.0]
  def change
    # create_table :posts_take2s do |t|
    #   t.timestamps
    # end
    def change
      drop_table :posts
      
      create_table :posts do |t|
        t.references :user, null: false, foreign_key: true
        t.text :content, null: false
        t.integer :post_type, default: 0
        t.boolean :verified, default: false
        t.integer :points_earned, default: 0
        t.datetime :activity_date
        t.string :location

        t.timestamps
      end
    
      add_index :posts, [:user_id, :created_at]
      add_index :posts, :post_type
      add_index :posts, :verified
    end
  end
end
