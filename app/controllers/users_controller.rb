class UsersController < ApplicationController
  before_action :authenticate_user!
  # before_action :check_if_admin
  # before_action :check_if_super_admin, only: [ :edit, :update, :new, :create, :destroy ]
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]
  before_action :ensure_current_user, only: [:edit, :update]

  def index
    # handle_search
    #@users = User.order(:first_name, :last_name)
    @users = User.where.not(id: current_user.id)
                 .order(:first_name, :last_name, :email)
                 .page(params[:page]).per(20)
    
  end
  
  def show
    @posts = @user.posts.includes(:user).recent.page(params[:page]).per(10)
    @relationship = current_user.active_relationships.find_by(followed_id: @user.id)
  end
  
  def edit
  end
  
  # def update
  #    if @user.update(user_params)
  #      redirect_to @user, notice: 'Profile was successfully updated.'
  #    else
  #      render :edit
  #    end
  # end
  def update
    update_params = user_params.dup
    if update_params[:email].present? && update_params[:email] != @user.email
      # @user.skip_confirmation!
      @user.skip_email_changed_notification!
      @user.skip_reconfirmation!
    end
    update_params.delete(:password) if update_params[:password].blank?

    if @user.update(update_params)
      redirect_to users_path, notice: "User [#{@user.full_name}] with Id: #{@user.id} has been updated successfully"
    else
      respond_to do |format|
        format.html { render :edit }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("edit_user_#{@user.id}", partial: "users/form", locals: { user: @user }) }
      end
    end
  end
  

  def create
    create_params = user_params.dup
    create_params[:username] = create_params[:email] if create_params[:username].blank?
    @user = User.new(create_params)
    if @user.save
      redirect_to users_path, notice: "User [#{@user.full_name}] with Id: #{@user.id} has been created successfully"
    else
      respond_to do |format|
        format.html { render :new }
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@user, partial: "users/form", locals: { user: @user }) }
      end
    end
  end


  def new
    @user = User.new(role: :user)
  end



  def destroy
    if @user.destroy
      redirect_to users_path, notice: "User [#{@user.full_name}] with Id: #{@user.id} has been deleted successfully"
    else
      redirect_to users_path, alert: "Failed to delete user [#{@user.full_name}] with Id: #{@user.id}"
    end
  end

  private
  
  private

  def ensure_current_user
    redirect_to root_path unless @user == current_user
  end

  def set_user
    #@user = User.find(params[:id])
    @user = User.where(username: params[:id]).first
  end


  def user_params
    fields = params.require(:user).permit(:first_name, :last_name,
      :email, :username, :password, :date_of_birth, :bio, :location,:political_interests, :public_profile, :avatar)

    if params.dig(:user, :disable_login).present?
      fields[:locked_at] = Time.current
    end

    if current_user.super_admin?
      role = params.dig(:user, :role)&.to_sym
      fields[:role] = role if role.present?
    end

    fields
  end

  def check_if_admin
    unless current_user.admin?
      render("errors/permission_denied", status: :forbidden) and return
    end
  end

  def check_if_super_admin
    unless current_user.super_admin?
      render("errors/actions_on_user_denied", status: :forbidden) and return
    end
  end

  def handle_search
    search_keyword = params[:keyword]
    role = params[:role]

    query = User.where(%Q{
          first_name LIKE lower(:keyword) OR
          last_name LIKE lower(:keyword) OR
          email LIKE lower(:keyword) OR
          username LIKE lower(:keyword)
        }, keyword: "%#{search_keyword}%")
    query = query.where(role: role) if role.present?

    @users = query.order(:first_name, :last_name)
  end
end
