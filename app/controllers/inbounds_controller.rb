class InboundsController < ApplicationController
  before_action :set_inbound, only: [:show, :edit, :update, :destroy]

  # GET /inbounds
  # GET /inbounds.json
  def index
    @inbounds = Inbound.page(params[:page]).all
  end

  # GET /inbounds/1
  # GET /inbounds/1.json
  def show
  end

  # GET /inbounds/new
  def new
    @inbound = Inbound.new
  end

  # GET /inbounds/1/edit
  def edit
  end

  # POST /inbounds
  # POST /inbounds.json
  def create
    @inbound = Inbound.new(inbound_params)

    respond_to do |format|
      if @inbound.save
        format.html { redirect_to @inbound, notice: 'Inbound was successfully created.' }
        format.json { render :show, status: :created, location: @inbound }
      else
        format.html { render :new }
        format.json { render json: @inbound.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inbounds/1
  # PATCH/PUT /inbounds/1.json
  def update
    respond_to do |format|
      if @inbound.update(inbound_params)
        format.html { redirect_to @inbound, notice: 'Inbound was successfully updated.' }
        format.json { render :show, status: :ok, location: @inbound }
      else
        format.html { render :edit }
        format.json { render json: @inbound.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inbounds/1
  # DELETE /inbounds/1.json
  def destroy
    @inbound.destroy
    respond_to do |format|
      format.html { redirect_to inbounds_url, notice: 'Inbound was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inbound
      @inbound = Inbound.from_user(current_user).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inbound_params
      params.require(:inbound).permit(:endpoint_id, :name, :host, :username, :password, :register, :cid_name, :cid_number)
    end
end
