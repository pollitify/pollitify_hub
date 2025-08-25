class Achievement < ApplicationRecord
  belongs_to :user

  validates :achievement_type, presence: true
  validates :milestone_value, presence: true, numericality: { greater_than: 0 }
  validates :achieved_at, presence: true

  enum :achievement_type, {
    points_milestone: 0,
    posts_milestone: 1,
    followers_milestone: 2,
    streak_milestone: 3,
    first_post: 4,
    first_follow: 5,
    first_like: 6
  }

  scope :recent, -> { order(achieved_at: :desc) }
  scope :by_type, ->(type) { where(achievement_type: type) }

  def self.milestone_values
    {
      points_milestone: [10, 25, 50, 100, 250, 500, 1000],
      posts_milestone: [1, 5, 10, 25, 50, 100],
      followers_milestone: [1, 5, 10, 25, 50, 100],
      streak_milestone: [3, 7, 14, 30, 60, 100]
    }
  end

  def display_name
    case achievement_type
    when 'points_milestone'
      "#{milestone_value} Points Earned"
    when 'posts_milestone'
      "#{milestone_value} Posts Shared"
    when 'followers_milestone'
      "#{milestone_value} Followers"
    when 'streak_milestone'
      "#{milestone_value} Day Streak"
    when 'first_post'
      "First Post"
    when 'first_follow'
      "First Follow"
    when 'first_like'
      "First Like"
    else
      achievement_type.humanize
    end
  end

  def icon
    case achievement_type
    when 'points_milestone'
      'trophy'
    when 'posts_milestone'
      'edit'
    when 'followers_milestone'
      'users'
    when 'streak_milestone'
      'fire'
    when 'first_post'
      'pen'
    when 'first_follow'
      'user-plus'
    when 'first_like'
      'thumbs-up'
    else
      'star'
    end
  end
end