class Post < ApplicationRecord
  belongs_to :user
  
  # You already have acts_as_votable
  acts_as_votable

  # Post types focused on activism
  enum :post_type, {
    general: 0,
    event_attendance: 1,
    canvassing: 2,
    phone_banking: 3,
    donation: 4,
    volunteer_work: 5,
    rally_attendance: 6,
    voter_registration: 7,
    petition_gathering: 8, 
    speaking_at_an_event: 9
  }

  validates :content, presence: true, length: { maximum: 1000 }
  validates :post_type, presence: true

  # Scopes
  scope :recent, -> { order(created_at: :desc) }
  scope :verified, -> { where(verified: true) }
  scope :activism_posts, -> { where.not(post_type: 'general') }

  # Auto-assign points based on post type when verified
  before_save :assign_points, if: :verified_changed_to_true?
  after_create :record_first_post_achievement
  after_update :check_badges_and_achievements, if: :saved_change_to_verified?

  def post_type_display
    post_type.humanize.titleize
  end

  def activism_post?
    !general?
  end

  private

  def verified_changed_to_true?
    verified_changed? && verified?
  end

  def assign_points
    point_values = {
      'general' => 1,
      'event_attendance' => 10,
      'canvassing' => 15,
      'phone_banking' => 8,
      'donation' => 5,
      'volunteer_work' => 12,
      'rally_attendance' => 10,
      'voter_registration' => 20,
      'petition_gathering' => 8,
      'social_media_posting' => 3,
      'speaking_at_an_event' => 20
    }
    
    self.points_earned = point_values[post_type] || 1
  end

  def record_first_post_achievement
    unless user.achievements.first_post.exists?
      user.achievements.create!(
        achievement_type: 'first_post',
        milestone_value: 1,
        achieved_at: created_at
      )
    end
  end

  def check_badges_and_achievements
    # Note: This runs in background, so no session for notifications
    BadgeNotificationService.check_and_notify(user)
    BadgeNotificationService.check_achievements(user)
  end
end