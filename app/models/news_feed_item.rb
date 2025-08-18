class NewsFeedItem < ApplicationRecord
  require "nokogiri"
  
  validates_uniqueness_of :permalink
  
  belongs_to :news_feed_url
  scope :ordered_by_date, -> { order(published_at: :desc) }
  
  acts_as_votable
  
  has_many :comments, dependent: :destroy
  
  #has_many :votes, dependent: :destroy
  
  IDENTITY_RELATIONSHIP = :all # could also be :all
  IDENTITY_COLUMNS = [:permalink]
  include FindOrCreate

  # def score
  #   self.votes.sum(:value)
  # end
  #
  # def upvotes
  #   votes.where(value: 1).count
  # end
  #
  # def downvotes
  #   votes.where(value: -1).count
  # end
  
  # def score
  #   Vote.where(votable: self).sum(:value)
  # end
  
  def score
    self.get_upvotes.size - self.get_downvotes.size
  end

  # def upvotes
  #   Vote.where(votable: self, value: 1).count
  # end
  #
  # def downvotes
  #   Vote.where(votable: self, value: -1).count
  # end
  
  def add_permalink
    cleaned = summary.gsub(/\A<!\[CDATA\[|\]\]>\Z/, "")

    doc = Nokogiri::HTML.fragment(cleaned)

    first_href_src = doc.at("a")&.[]("href")

    self.permalink = first_href_src
    self.save
  end
end
