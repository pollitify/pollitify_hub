class CongressionalDistrictsController < ApplicationController
  before_action :set_congressional_district, only: %i[ show edit update destroy ]

  # GET /congressional_districts or /congressional_districts.json
  def index
    @congressional_districts = CongressionalDistrict.all
  end

  # GET /congressional_districts/1 or /congressional_districts/1.json
  def show
  end

  # GET /congressional_districts/new
  def new
    @congressional_district = CongressionalDistrict.new
  end

  # GET /congressional_districts/1/edit
  def edit
  end

  # POST /congressional_districts or /congressional_districts.json
  def create
    @congressional_district = CongressionalDistrict.new(congressional_district_params)

    respond_to do |format|
      if @congressional_district.save
        format.html { redirect_to @congressional_district, notice: "Congressional district was successfully created." }
        format.json { render :show, status: :created, location: @congressional_district }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @congressional_district.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /congressional_districts/1 or /congressional_districts/1.json
  def update
    respond_to do |format|
      if @congressional_district.update(congressional_district_params)
        format.html { redirect_to @congressional_district, notice: "Congressional district was successfully updated." }
        format.json { render :show, status: :ok, location: @congressional_district }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @congressional_district.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /congressional_districts/1 or /congressional_districts/1.json
  def destroy
    @congressional_district.destroy!

    respond_to do |format|
      format.html { redirect_to congressional_districts_path, status: :see_other, notice: "Congressional district was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_congressional_district
      @congressional_district = CongressionalDistrict.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def congressional_district_params
      params.expect(congressional_district: [ :name, :state_id, :key_city, :key_county_id ])
    end
end
