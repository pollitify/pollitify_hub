class UserBadge < ApplicationRecord
  belongs_to :user
  belongs_to :badge

  validates :user_id, uniqueness: { scope: :badge_id }
  validates :earned_at, presence: true
  validates :points_earned, numericality: { greater_than_or_equal_to: 0 }

  scope :recent, -> { order(earned_at: :desc) }
  scope :by_category, ->(category) { joins(:badge).where(badges: { category: category }) }

  before_validation :set_earned_at, if: :new_record?
  before_validation :set_points_earned, if: :new_record?

  private

  def set_earned_at
    self.earned_at ||= Time.current
  end

  def set_points_earned
    # Award bonus points for earning badges
    point_values = {
      'getting_started' => 5,
      'activism_type' => 10,
      'consistency' => 15,
      'social' => 8,
      'impact' => 20,
      'special' => 25
    }
    self.points_earned ||= point_values[badge.category] || 5
  end
end