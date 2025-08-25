class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow(@user)
    
    # Check for first follow achievement
    unless current_user.achievements.first_follow.exists?
      current_user.achievements.create!(
        achievement_type: 'first_follow',
        milestone_value: 1,
        achieved_at: Time.current
      )
    end
    
    # Check for badges and achievements
    BadgeNotificationService.check_and_notify(current_user, session)
    BadgeNotificationService.check_achievements(current_user)
    
    respond_to do |format|
      format.html { redirect_to @user, notice: "Now following #{@user.display_name}" }
      #format.turbo_stream
    end
  end

  def destroy
    @relationship = current_user.active_relationships.find(params[:id])
    @user = @relationship.followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user, notice: "Unfollowed #{@user.display_name}" }
      format.turbo_stream
    end
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(20)
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(20)
    render 'show_follow'
  end
end