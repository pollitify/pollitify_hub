class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :news_feed_item
  
  validates :user_id, uniqueness: { scope: :news_feed_item_id }
  validates :value, inclusion: { in: [1, -1] }
end
