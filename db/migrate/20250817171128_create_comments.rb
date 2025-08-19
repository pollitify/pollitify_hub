class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.references :news_feed_item, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
