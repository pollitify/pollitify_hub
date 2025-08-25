class Badge < ApplicationRecord
  
  enum :category, {
    getting_started: 0,
    activism_type: 1,
    consistency: 2,
    social: 3,
    impact: 4,
    special: 5
  }
  
  enum :requirement_type, {
    total_posts: 0,
    post_type_count: 1,
    total_points: 2,
    consecutive_days: 3,
    followers_count: 4,
    following_count: 5,
    likes_received: 6,
    specific_activity: 7,
    days_active: 8
  }
  
  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :requirement_type, presence: true
  validates :requirement_value, presence: true, numericality: { greater_than: 0 }
  validates :category, presence: true
  validates :icon, presence: true
  validates :color, presence: true
  
  #extend ActiveRecord::Enum



  scope :active, -> { where(active: true) }
  scope :by_category, ->(cat) { where(category: cat) }

  def earned_by?(user)
    user_badges.exists?(user: user)
  end

  def progress_for(user)
    case requirement_type
    when 'total_posts'
      [user.posts.count, requirement_value].min
    when 'post_type_count'
      # Requires additional logic based on verification_data
      count = case name.downcase
              when /canvass/i
                user.posts.canvassing.count
              when /phone/i
                user.posts.phone_banking.count
              when /event/i
                user.posts.event_attendance.count
              when /rally/i
                user.posts.rally_attendance.count
              when /voter/i
                user.posts.voter_registration.count
              when /volunteer/i
                user.posts.volunteer_work.count
              when /donation/i
                user.posts.donation.count
              else
                0
              end
      [count, requirement_value].min
    when 'total_points'
      [user.total_activism_points, requirement_value].min
    when 'followers_count'
      [user.followers.count, requirement_value].min
    when 'following_count'
      [user.following.count, requirement_value].min
    when 'likes_received'
      total_likes = user.posts.sum { |post| post.get_upvotes.size }
      [total_likes, requirement_value].min
    when 'consecutive_days'
      # This would need more complex logic to track streaks
      0
    when 'days_active'
      days = user.posts.group('DATE(created_at)').count.size
      [days, requirement_value].min
    else
      0
    end
  end

  def progress_percentage_for(user)
    ((progress_for(user).to_f / requirement_value) * 100).round(1)
  end

  def requirements_met_by?(user)
    progress_for(user) >= requirement_value
  end
end
