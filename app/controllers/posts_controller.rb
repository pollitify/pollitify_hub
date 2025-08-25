class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[ show edit update destroy upvote downvote ]
  before_action :ensure_owner, only: %i[ edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.includes(:user).recent.page(params[:page]).per(15)
    @post = Post.new # for the new post form
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = current_user.posts.build
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        # Check for badges and achievements
        BadgeNotificationService.check_and_notify(current_user, session)
        BadgeNotificationService.check_achievements(current_user)
        
        format.html { redirect_to posts_path, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
        #format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_path, notice: "Post was successfully deleted." }
      format.json { head :no_content }
    end
  end

  def upvote
    @post.upvote_by(current_user)
    respond_to do |format|
      format.html { redirect_back(fallback_location: posts_path) }
      format.turbo_stream
    end
  end

  def downvote
    @post.downvote_by(current_user)
    respond_to do |format|
      format.html { redirect_back(fallback_location: posts_path) }
      format.turbo_stream
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def ensure_owner
    redirect_to posts_path unless @post.user == current_user
  end

  def post_params
    params.require(:post).permit(:content, :post_type, :activity_date, :location)
  end
end