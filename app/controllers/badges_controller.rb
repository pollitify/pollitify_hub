class BadgesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_badge, only: [:show]

  def index
    @earned_badges = current_user.badges.includes(:user_badges)
                                .joins(:user_badges)
                                .order('user_badges.earned_at DESC')
    
    @available_badges = current_user.available_badges.active
    @badge_categories = Badge.categories.keys
    @recent_achievements = current_user.achievements.recent.limit(10)
    
    @progress_stats = {
      total_badges: Badge.active.count,
      earned_badges: @earned_badges.count,
      completion_percentage: current_user.badge_completion_percentage
    }
  end

  def show
    @user_badge = current_user.user_badges.find_by(badge: @badge)
    @progress = @badge.progress_for(current_user)
    @progress_percentage = @badge.progress_percentage_for(current_user)
    @requirements_met = @badge.requirements_met_by?(current_user)
  end

  private

  def set_badge
    @badge = Badge.find(params[:id])
  end
end