class SecureChatSystemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_secure_chat_system, only: %i[ show edit update destroy ]

  # GET /secure_chat_systems or /secure_chat_systems.json
  def index
    @secure_chat_systems = SecureChatSystem.all
  end

  # GET /secure_chat_systems/1 or /secure_chat_systems/1.json
  def show
  end

  # GET /secure_chat_systems/new
  def new
    @secure_chat_system = SecureChatSystem.new
  end

  # GET /secure_chat_systems/1/edit
  def edit
  end

  # POST /secure_chat_systems or /secure_chat_systems.json
  def create
    @secure_chat_system = SecureChatSystem.new(secure_chat_system_params)
    #debugger if Rails.env.test?
    respond_to do |format|
      if @secure_chat_system.save
        format.html { redirect_to @secure_chat_system, notice: "Secure chat system was successfully created." }
        format.json { render :show, status: :created, location: @secure_chat_system }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @secure_chat_system.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /secure_chat_systems/1 or /secure_chat_systems/1.json
  def update
    respond_to do |format|
      if @secure_chat_system.update(secure_chat_system_params)
        format.html { redirect_to @secure_chat_system, notice: "Secure chat system was successfully updated." }
        format.json { render :show, status: :ok, location: @secure_chat_system }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @secure_chat_system.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /secure_chat_systems/1 or /secure_chat_systems/1.json
  def destroy
    @secure_chat_system.destroy!

    respond_to do |format|
      format.html { redirect_to secure_chat_systems_path, status: :see_other, notice: "Secure chat system was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_secure_chat_system
      @secure_chat_system = SecureChatSystem.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def secure_chat_system_params
      params.expect(secure_chat_system: [ :name, :fid, :url, :icon_url, :description ])
    end
end
