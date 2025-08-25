class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :timeoutable, :trackable
         #:confirmable, 
  
  
  belongs_to :state, optional: true
  belongs_to :county, optional: true
  belongs_to :city, optional: true
  belongs_to :federal_congressional_district, class_name: "CongressionalDistrict", optional: true
  belongs_to :state_congressional_district, class_name: "CongressionalDistrict", optional: true
  
  has_one_attached :avatar
  
  has_many :user_roles
  has_many :roles, through: :user_roles
  # Posts association
  has_many :posts, dependent: :destroy
  # Self-referential many-to-many for follows
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  # Badge associations
  has_many :user_badges, dependent: :destroy
  has_many :badges, through: :user_badges
  has_many :achievements, dependent: :destroy
  
  # Acts as votable (you already have this)
  acts_as_votable
  
  IDENTITY_RELATIONSHIP = :all # could also be :all
  IDENTITY_COLUMNS = [:username, :email]
  include FindOrCreate
  
  
  # Validations
  validates :bio, length: { maximum: 500 }
  validates :location, length: { maximum: 100 }
  validates :email, presence: true, uniqueness: true
  # validates :password, presence: true
  # validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  #validates :username, presence: true, uniqueness: true
  # validates :username, presence: true,
  #                      uniqueness: { case_sensitive: false },
  #                      length: { minimum: 3, maximum: 20 }
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :password, length: { maximum: 20 }
  validate :valid_date?
  
  attr_accessor :login
  
  #
  # Turn off sending a password change email 
  #
  def send_password_change_notification?
    false
  end
  
  # Helper methods for following functionality
  def follow(other_user)
    following << other_user unless following?(other_user) || self == other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def political_interests_array
    political_interests.present? ? political_interests.split(',').map(&:strip) : []
  end

  def political_interests_array=(interests)
    self.political_interests = interests.join(', ')
  end

  def display_name
    "#{first_name} #{last_name}".strip.presence || email.split('@').first
  end

  def total_activism_points
    posts.where(verified: true).sum(:points_earned)
  end
  
  def earned_badges
    badges.includes(:user_badges)
  end

  def available_badges
    Badge.active.where.not(id: badge_ids)
  end

  def recent_badges(limit = 5)
    user_badges.recent.includes(:badge).limit(limit)
  end

  def badges_by_category(category)
    badges.by_category(category)
  end

  def check_and_award_badges!
    Badge.active.each do |badge|
      next if badge.earned_by?(self)
      award_badge!(badge) if badge.requirements_met_by?(self)
    end
  end

  def award_badge!(badge)
    return if badges.include?(badge)
    
    user_badges.create!(
      badge: badge,
      verification_data: { awarded_for: badge.requirement_type }
    )
    
    # Could add notification logic here
    Rails.logger.info "User #{id} earned badge: #{badge.name}"
  end

  def check_and_record_achievements!
    # Check point milestones
    Achievement.milestone_values[:points_milestone].each do |milestone|
      next if achievements.points_milestone.exists?(milestone_value: milestone)
      
      if total_activism_points >= milestone
        achievements.create!(
          achievement_type: 'points_milestone',
          milestone_value: milestone,
          achieved_at: Time.current
        )
      end
    end
    
    # Check post milestones
    Achievement.milestone_values[:posts_milestone].each do |milestone|
      next if achievements.posts_milestone.exists?(milestone_value: milestone)
      
      if posts.count >= milestone
        achievements.create!(
          achievement_type: 'posts_milestone',
          milestone_value: milestone,
          achieved_at: Time.current
        )
      end
    end
    
    # Check follower milestones
    Achievement.milestone_values[:followers_milestone].each do |milestone|
      next if achievements.followers_milestone.exists?(milestone_value: milestone)
      
      if followers.count >= milestone
        achievements.create!(
          achievement_type: 'followers_milestone',
          milestone_value: milestone,
          achieved_at: Time.current
        )
      end
    end
  end

  def badge_completion_percentage
    return 0 if Badge.active.count == 0
    ((badges.count.to_f / Badge.active.count) * 100).round(1)
  end
  
  def state?
    return true if self.state
  end
  


  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions).where(
        ["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]
      ).first
    else
      where(conditions).first
    end
  end

  # enum :role, { user: "user", admin: "admin" }
  # validates :role, inclusion: { in: roles.keys }


  def full_name
    [ first_name, last_name ].join(" ")
  end

  def super_admin?
    admin? && email == ENV["ADMIN_EMAIL"]
  end
  
  acts_as_voter
  
  has_many :user_roles
  has_many :roles, through: :user_roles
  
  def is_superuser?
    return true if self.username == 'fuzzygroup'
  end
  
  def is_admin?
    roles.exists?(name: "admin")
  end
  
  def is_leadership?
    roles.exists?(name: "leadership")
  end
  
  def is_safety?
    roles.exists?(name: "safety")
  end
  
  def is_social_media?
    roles.exists?(name: "social_media")
  end

  def is_socialmedia?
    roles.exists?(name: "social_media")
  end

  
  def is_super_user?
    roles.exists?(name: "super_user")
  end
  
  def is_superuser?
    roles.exists?(name: "super_user")
  end
  
  def is_volunteer?
    roles.exists?(name: "volunteer")    
  end
  
  def is_editor?
    roles.exists?(name: "editor")    
  end
  
  
  # You can dynamically define role-checking methods like:
  #
  # ruby
  # Copy
  # Edit
  # app/models/user.rb
  # Role.pluck(:name).each do |role_name|
  #   define_method("#{role_name}?") do
  #     has_role?(role_name)
  #   end
  # end
  #Now you can call current_user.admin?, current_user.super_user?, etc.
  
  def self.taelar
    User.where(username: 'taelar').first
  end
  
  def self.alex
    User.where(username: 'alex').first
  end
  
  def self.kayla
    User.where(username: 'kayla').first
  end

  def self.scott
    User.where(username: 'fuzzygroup').first
  end

  def self.fuzzygroup
    User.where(username: 'fuzzygroup').first
  end

  
  def has_role?(role_name)
    roles.exists?(name: role_name.to_s)
  end
  
  def is_super_user?
    return true if self.has_role?("super_user")
    return true if self.email =~ /fuzzygroup/i
    return false
  end
  
  def admin?
    return true if self.has_role?("admin")
    return false
  end
  
  def has_editing_privileges?
    return true if self.has_role?("editor")
    return false
  end
  
  def is_admin?
    return true if self.email =~ /fuzzygroup/
  end
  
  def has_destroy_rights?(foo)
    return true if self.email =~ /fuzzygroup/
  end
  
  def to_param
    username.parameterize
  end
  

  private

  def valid_date?
    if date_of_birth.present? && date_of_birth > Time.now.ago(15.years)
      errors.add(:date_of_birth, "must be at least 15 years old")
    end
  end
end
