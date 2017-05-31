class OutboundsController < ApplicationController
  before_action :set_outbound, only: [:show, :edit, :update, :destroy]

  # GET /outbounds
  # GET /outbounds.json
  def index
    authorize! :read, :outbounds
    @outbounds = Outbound.all
  end

  # GET /outbounds/1
  # GET /outbounds/1.json
  def show
    authorize! :read, :outbounds
  end

  # GET /outbounds/new
  def new
    authorize! :create, :outbounds
    @outbound = Outbound.new
  end

  # GET /outbounds/1/edit
  def edit
    authorize! :update, :outbounds
  end

  # POST /outbounds
  # POST /outbounds.json
  def create
    authorize! :create, :outbounds
    @outbound = Outbound.new(outbound_params)

    respond_to do |format|
      if @outbound.save
        format.html { redirect_to @outbound, notice: 'Outbound was successfully created.' }
        format.json { render :show, status: :created, location: @outbound }
      else
        format.html { render :new }
        format.json { render json: @outbound.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /outbounds/1
  # PATCH/PUT /outbounds/1.json
  def update
    authorize! :update, :outbounds
    respond_to do |format|
      if @outbound.update(outbound_params)
        format.html { redirect_to @outbound, notice: 'Outbound was successfully updated.' }
        format.json { render :show, status: :ok, location: @outbound }
      else
        format.html { render :edit }
        format.json { render json: @outbound.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /outbounds/1
  # DELETE /outbounds/1.json
  def destroy
    authorize! :delete, :outbounds
    @outbound.destroy
    respond_to do |format|
      format.html { redirect_to outbounds_url, notice: 'Outbound was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_outbound
      @outbound = Outbound.from_user(current_user).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def outbound_params
      params.require(:outbound).permit(:endpoint_id, :name, :realm, :username, :password, :register, :cidfrom, :codecs, :proxy, :cid_name, :cid_number)
    end
end
