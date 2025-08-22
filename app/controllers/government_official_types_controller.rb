class GovernmentOfficialTypesController < ApplicationController
  before_action :set_government_official_type, only: %i[ show edit update destroy ]

  # GET /government_official_types or /government_official_types.json
  def index
    @government_official_types = GovernmentOfficialType.all
  end

  # GET /government_official_types/1 or /government_official_types/1.json
  def show
  end

  # GET /government_official_types/new
  def new
    @government_official_type = GovernmentOfficialType.new
  end

  # GET /government_official_types/1/edit
  def edit
  end

  # POST /government_official_types or /government_official_types.json
  def create
    @government_official_type = GovernmentOfficialType.new(government_official_type_params)

    respond_to do |format|
      if @government_official_type.save
        format.html { redirect_to @government_official_type, notice: "Government official type was successfully created." }
        format.json { render :show, status: :created, location: @government_official_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @government_official_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /government_official_types/1 or /government_official_types/1.json
  def update
    respond_to do |format|
      if @government_official_type.update(government_official_type_params)
        format.html { redirect_to @government_official_type, notice: "Government official type was successfully updated." }
        format.json { render :show, status: :ok, location: @government_official_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @government_official_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /government_official_types/1 or /government_official_types/1.json
  def destroy
    @government_official_type.destroy!

    respond_to do |format|
      format.html { redirect_to government_official_types_path, status: :see_other, notice: "Government official type was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_government_official_type
      @government_official_type = GovernmentOfficialType.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def government_official_type_params
      params.expect(government_official_type: [ :name, :fid ])
    end
end
