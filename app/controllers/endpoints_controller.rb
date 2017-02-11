class EndpointsController < ApplicationController
  before_action :set_endpoint, only: [:rpc, :show, :edit, :update, :destroy]

  # GET /endpoints
  # GET /endpoints.json
  def index
    @endpoints = Endpoint.page(params[:page]).all
  end

  # GET /endpoints/1
  # GET /endpoints/1.json
  def show
  end

  # GET /endpoints/new
  def new
    @endpoint = Endpoint.new
  end

  # GET /endpoints/1/edit
  def edit
  end

  # POST /endpoints
  # POST /endpoints.json
  def create
    @endpoint = Endpoint.new(endpoint_params)
    @endpoint.freeswitch_id = nil unless current_user.freeswitches.pluck(:id).member?(@endpoint.freeswitch_id)
    respond_to do |format|
      if @endpoint.save
        format.html { redirect_to @endpoint, notice: 'Endpoint was successfully created.' }
        format.json { render :show, status: :created, location: @endpoint }
      else
        format.html { render :new }
        format.json { render json: @endpoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /endpoints/1
  # PATCH/PUT /endpoints/1.json
  def update
    respond_to do |format|
      if @endpoint.update(endpoint_params)
        format.html { redirect_to @endpoint, notice: 'Endpoint was successfully updated.' }
        format.json { render :show, status: :ok, location: @endpoint }
      else
        format.html { render :edit }
        format.json { render json: @endpoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /endpoints/1
  # DELETE /endpoints/1.json
  def destroy
    @endpoint.destroy
    respond_to do |format|
      format.html { redirect_to endpoints_url, notice: 'Endpoint was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def rpc
    case params[:cmd]
    when 'rescan'
      @endpoint.rpc_rescan!
    when 'stop'
      @endpoint.rpc_stop!
    when 'start'
      @endpoint.rpc_start!
    end
    flash[:notice] = 'Please wait a minute(s) and refresh'
    redirect_to endpoints_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_endpoint
      @endpoint = Endpoint.where(freeswitch_id: current_user.freeswitches.pluck(:id)).find_by(:id => params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def endpoint_params
      params.require(:endpoint).permit(:domain, :freeswitch_id, :address, :port)
    end

end
