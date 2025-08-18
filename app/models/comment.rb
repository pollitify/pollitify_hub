class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :news_feed_item

  validates :body, presence: true
  
  def self.already_exists?(comment_params)
    #debugger
    return true if Comment.where(user_id: comment_params[:user_id]).where(body: comment_params[:body]).first
    return false
  end
end
