class CongressionalDistrictTypesController < ApplicationController
  before_action :set_congressional_district_type, only: %i[ show edit update destroy ]

  # GET /congressional_district_types or /congressional_district_types.json
  def index
    @congressional_district_types = CongressionalDistrictType.all
  end

  # GET /congressional_district_types/1 or /congressional_district_types/1.json
  def show
  end

  # GET /congressional_district_types/new
  def new
    @congressional_district_type = CongressionalDistrictType.new
  end

  # GET /congressional_district_types/1/edit
  def edit
  end

  # POST /congressional_district_types or /congressional_district_types.json
  def create
    @congressional_district_type = CongressionalDistrictType.new(congressional_district_type_params)

    respond_to do |format|
      if @congressional_district_type.save
        format.html { redirect_to @congressional_district_type, notice: "Congressional district type was successfully created." }
        format.json { render :show, status: :created, location: @congressional_district_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @congressional_district_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /congressional_district_types/1 or /congressional_district_types/1.json
  def update
    respond_to do |format|
      if @congressional_district_type.update(congressional_district_type_params)
        format.html { redirect_to @congressional_district_type, notice: "Congressional district type was successfully updated." }
        format.json { render :show, status: :ok, location: @congressional_district_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @congressional_district_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /congressional_district_types/1 or /congressional_district_types/1.json
  def destroy
    @congressional_district_type.destroy!

    respond_to do |format|
      format.html { redirect_to congressional_district_types_path, status: :see_other, notice: "Congressional district type was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_congressional_district_type
      @congressional_district_type = CongressionalDistrictType.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def congressional_district_type_params
      params.expect(congressional_district_type: [ :name, :fid ])
    end
end
