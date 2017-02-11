class ExtensionProfilesController < ApplicationController
  before_action :set_extension_profile, only: [:show, :edit, :update, :destroy]

  # GET /extension_profiles
  # GET /extension_profiles.json
  def index
    @extension_profiles = ExtensionProfile.all
  end

  # GET /extension_profiles/1
  # GET /extension_profiles/1.json
  def show
  end

  # GET /extension_profiles/new
  def new
    @extension_profile = ExtensionProfile.new
  end

  # GET /extension_profiles/1/edit
  def edit
  end

  # POST /extension_profiles
  # POST /extension_profiles.json
  def create
    @extension_profile = ExtensionProfile.new(extension_profile_params)

    respond_to do |format|
      if @extension_profile.save
        format.html { redirect_to @extension_profile, notice: 'Extension profile was successfully created.' }
        format.json { render :show, status: :created, location: @extension_profile }
      else
        format.html { render :new }
        format.json { render json: @extension_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /extension_profiles/1
  # PATCH/PUT /extension_profiles/1.json
  def update
    respond_to do |format|
      if @extension_profile.update(extension_profile_params)
        format.html { redirect_to @extension_profile, notice: 'Extension profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @extension_profile }
      else
        format.html { render :edit }
        format.json { render json: @extension_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /extension_profiles/1
  # DELETE /extension_profiles/1.json
  def destroy
    @extension_profile.destroy
    respond_to do |format|
      format.html { redirect_to extension_profiles_url, notice: 'Extension profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_extension_profile
      @extension_profile = ExtensionProfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def extension_profile_params
      params.require(:extension_profile).permit(:name)
    end
end
