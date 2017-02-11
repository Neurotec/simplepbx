class Callcenter::TiersController < ApplicationController
  before_action :set_callcenter_tier, only: [:show, :edit, :update, :destroy]

  # GET /callcenter/tiers
  # GET /callcenter/tiers.json
  def index
    @callcenter_tiers = Callcenter::Tier.order(position: :asc).page(params[:page]).all
  end

  # GET /callcenter/tiers/1
  # GET /callcenter/tiers/1.json
  def show
  end

  # GET /callcenter/tiers/new
  def new
    @callcenter_tier = Callcenter::Tier.new
  end

  # GET /callcenter/tiers/1/edit
  def edit
  end

  # POST /callcenter/tiers
  # POST /callcenter/tiers.json
  def create
    @callcenter_tier = Callcenter::Tier.new(callcenter_tier_params)

    respond_to do |format|
      if @callcenter_tier.save
        format.html { redirect_to @callcenter_tier, notice: 'Tier was successfully created.' }
        format.json { render :show, status: :created, location: @callcenter_tier }
      else
        format.html { render :new }
        format.json { render json: @callcenter_tier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /callcenter/tiers/1
  # PATCH/PUT /callcenter/tiers/1.json
  def update
    respond_to do |format|
      if @callcenter_tier.update(callcenter_tier_params)
        format.html { redirect_to @callcenter_tier, notice: 'Tier was successfully updated.' }
        format.json { render :show, status: :ok, location: @callcenter_tier }
      else
        format.html { render :edit }
        format.json { render json: @callcenter_tier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /callcenter/tiers/1
  # DELETE /callcenter/tiers/1.json
  def destroy
    @callcenter_tier.destroy
    respond_to do |format|
      format.html { redirect_to callcenter_tiers_url, notice: 'Tier was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_callcenter_tier
      @callcenter_tier = Callcenter::Tier.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def callcenter_tier_params
      params.require(:callcenter_tier).permit(:extension_id, :callcenter_queue_id, :level, :position)
    end
end
