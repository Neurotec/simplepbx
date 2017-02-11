class FreeswitchesController < ApplicationController
  before_action :set_freeswitch, only: [:show, :edit, :update, :destroy]

  # GET /freeswitches
  # GET /freeswitches.json
  def index
    @freeswitches = Freeswitch.page(params[:page]).all
  end

  # GET /freeswitches/1
  # GET /freeswitches/1.json
  def show
    headers["Cache-Control"] = "no-cache"
  end

  # GET /freeswitches/new
  def new
    @freeswitch = Freeswitch.new
  end

  # GET /freeswitches/1/edit
  def edit
  end

  # POST /freeswitches
  # POST /freeswitches.json
  def create
    @freeswitch = Freeswitch.new(freeswitch_params)
    @freeswitch.user_id = current_user.id

    respond_to do |format|
      if @freeswitch.save
        format.html { redirect_to @freeswitch, notice: 'Freeswitch was successfully created.' }
        format.json { render :show, status: :created, location: @freeswitch }
      else
        format.html { render :new }
        format.json { render json: @freeswitch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /freeswitches/1
  # PATCH/PUT /freeswitches/1.json
  def update
    respond_to do |format|
      if @freeswitch.update(freeswitch_params)
        format.html { redirect_to @freeswitch, notice: 'Freeswitch was successfully updated.' }
        format.json { render :show, status: :ok, location: @freeswitch }
      else
        format.html { render :edit }
        format.json { render json: @freeswitch.errors, status: :unprocessable_entity }
      end
    end
  end

  
  # DELETE /freeswitches/1
  # DELETE /freeswitches/1.json
  def destroy
    @freeswitch.destroy
    respond_to do |format|
      format.html { redirect_to freeswitches_url, notice: 'Freeswitch was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_freeswitch
      @freeswitch = Freeswitch.find_by(user_id: current_user.id, id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def freeswitch_params
      params.require(:freeswitch).permit(:host, :event_socket_port, :event_socket_password, :name, :xml_rpc_user, :xml_rpc_realm, :xml_rpc_pass, :xml_rpc_port, :record_public_user)
    end

end
