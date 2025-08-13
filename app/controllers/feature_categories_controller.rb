class FeatureCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_feature_category, only: %i[ show edit update destroy ]

  # GET /feature_categories or /feature_categories.json
  def index
    @feature_categories = FeatureCategory.all
  end

  # GET /feature_categories/1 or /feature_categories/1.json
  def show
  end

  # GET /feature_categories/new
  def new
    @feature_category = FeatureCategory.new
  end

  # GET /feature_categories/1/edit
  def edit
  end

  # POST /feature_categories or /feature_categories.json
  def create
    @feature_category = FeatureCategory.new(feature_category_params)
    #debugger if Rails.env.development?
    respond_to do |format|
      if @feature_category.save
        format.html { redirect_to @feature_category, notice: "Feature category was successfully created." }
        format.json { render :show, status: :created, location: @feature_category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @feature_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feature_categories/1 or /feature_categories/1.json
  def update
    respond_to do |format|
      if @feature_category.update(feature_category_params)
        format.html { redirect_to @feature_category, notice: "Feature category was successfully updated." }
        format.json { render :show, status: :ok, location: @feature_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @feature_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feature_categories/1 or /feature_categories/1.json
  def destroy
    @feature_category.destroy!

    respond_to do |format|
      format.html { redirect_to feature_categories_path, status: :see_other, notice: "Feature category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feature_category
      @feature_category = FeatureCategory.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def feature_category_params
      params.expect(feature_category: [ :name, :fid ])
    end
end
