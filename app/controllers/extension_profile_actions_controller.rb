class ExtensionProfileActionsController < ApplicationController
  before_action :set_extension_profile_action, only: [:show, :edit, :update, :destroy]

  # GET /extension_profile_actions
  # GET /extension_profile_actions.json
  def index
    @extension_profile_actions = ExtensionProfileAction.all
  end

  # GET /extension_profile_actions/1
  # GET /extension_profile_actions/1.json
  def show
  end

  # GET /extension_profile_actions/new
  def new
    @extension_profile_action = ExtensionProfileAction.new
  end

  # GET /extension_profile_actions/1/edit
  def edit
  end

  # POST /extension_profile_actions
  # POST /extension_profile_actions.json
  def create
    @extension_profile_action = ExtensionProfileAction.new(extension_profile_action_params)

    respond_to do |format|
      if @extension_profile_action.save
        format.html { redirect_to @extension_profile_action, notice: 'Extension profile action was successfully created.' }
        format.json { render :show, status: :created, location: @extension_profile_action }
      else
        format.html { render :new }
        format.json { render json: @extension_profile_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /extension_profile_actions/1
  # PATCH/PUT /extension_profile_actions/1.json
  def update
    respond_to do |format|
      if @extension_profile_action.update(extension_profile_action_params)
        format.html { redirect_to @extension_profile_action, notice: 'Extension profile action was successfully updated.' }
        format.json { render :show, status: :ok, location: @extension_profile_action }
      else
        format.html { render :edit }
        format.json { render json: @extension_profile_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /extension_profile_actions/1
  # DELETE /extension_profile_actions/1.json
  def destroy
    @extension_profile_action.destroy
    respond_to do |format|
      format.html { redirect_to extension_profile_actions_url, notice: 'Extension profile action was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_extension_profile_action
      @extension_profile_action = ExtensionProfileAction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def extension_profile_action_params
      params.require(:extension_profile_action).permit(:extension_profile_id, :order, :application, :data)
    end
end
