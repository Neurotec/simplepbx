class DestinationProfilesController < ApplicationController
  before_action :set_destination_profile, only: [:show, :edit, :update, :destroy]

  # GET /destination_profiles
  # GET /destination_profiles.json
  def index
    @destination_profiles = DestinationProfile.all
  end

  # GET /destination_profiles/1
  # GET /destination_profiles/1.json
  def show
  end

  # GET /destination_profiles/new
  def new
    @destination_profile = DestinationProfile.new
  end

  # GET /destination_profiles/1/edit
  def edit
  end

  # POST /destination_profiles
  # POST /destination_profiles.json
  def create
    @destination_profile = DestinationProfile.new(destination_profile_params)

    respond_to do |format|
      if @destination_profile.save
        format.html { redirect_to @destination_profile, notice: 'Destination profile was successfully created.' }
        format.json { render :show, status: :created, location: @destination_profile }
      else
        format.html { render :new }
        format.json { render json: @destination_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /destination_profiles/1
  # PATCH/PUT /destination_profiles/1.json
  def update
    respond_to do |format|
      if @destination_profile.update(destination_profile_params)
        format.html { redirect_to @destination_profile, notice: 'Destination profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @destination_profile }
      else
        format.html { render :edit }
        format.json { render json: @destination_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /destination_profiles/1
  # DELETE /destination_profiles/1.json
  def destroy
    @destination_profile.destroy
    respond_to do |format|
      format.html { redirect_to destination_profiles_url, notice: 'Destination profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_destination_profile
      @destination_profile = DestinationProfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def destination_profile_params
      params.require(:destination_profile).permit(:name, :condition_field, :condition_expression)
    end
end
