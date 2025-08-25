class BadgeNotificationService
  def self.check_and_notify(user, session = nil)
    newly_earned_badges = []
    
    Badge.active.each do |badge|
      next if badge.earned_by?(user)
      
      if badge.requirements_met_by?(user)
        user_badge = user.user_badges.create!(
          badge: badge,
          verification_data: { awarded_for: badge.requirement_type }
        )
        newly_earned_badges << user_badge
      end
    end
    
    # Set flash message if we have a session (from controller)
    if session && newly_earned_badges.any?
      badge_names = newly_earned_badges.map { |ub| ub.badge.name }.join(', ')
      total_points = newly_earned_badges.sum(&:points_earned)
      
      session[:badge_notification] = {
        message: "🎉 Congratulations! You earned: #{badge_names} (+#{total_points} points)",
        badges: newly_earned_badges.map { |ub| { name: ub.badge.name, icon: ub.badge.icon, color: ub.badge.color } }
      }
    end
    
    newly_earned_badges
  end
  
  def self.check_achievements(user)
    # Check point milestones
    Achievement.milestone_values[:points_milestone].each do |milestone|
      next if user.achievements.points_milestone.exists?(milestone_value: milestone)
      
      if user.total_activism_points >= milestone
        user.achievements.create!(
          achievement_type: 'points_milestone',
          milestone_value: milestone,
          achieved_at: Time.current
        )
      end
    end
    
    # Check post milestones
    Achievement.milestone_values[:posts_milestone].each do |milestone|
      next if user.achievements.posts_milestone.exists?(milestone_value: milestone)
      
      if user.posts.count >= milestone
        user.achievements.create!(
          achievement_type: 'posts_milestone',
          milestone_value: milestone,
          achieved_at: Time.current
        )
      end
    end
    
    # Check follower milestones
    Achievement.milestone_values[:followers_milestone].each do |milestone|
      next if user.achievements.followers_milestone.exists?(milestone_value: milestone)
      
      if user.followers.count >= milestone
        user.achievements.create!(
          achievement_type: 'followers_milestone',
          milestone_value: milestone,
          achieved_at: Time.current
        )
      end
    end
  end
end