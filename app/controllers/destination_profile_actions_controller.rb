class DestinationProfileActionsController < ApplicationController
  before_action :set_destination_profile_action, only: [:show, :edit, :update, :destroy]

  # GET /destination_profile_actions
  # GET /destination_profile_actions.json
  def index
    @destination_profile_actions = DestinationProfileAction.all
  end

  # GET /destination_profile_actions/1
  # GET /destination_profile_actions/1.json
  def show
  end

  # GET /destination_profile_actions/new
  def new
    @destination_profile_action = DestinationProfileAction.new
  end

  # GET /destination_profile_actions/1/edit
  def edit
  end

  # POST /destination_profile_actions
  # POST /destination_profile_actions.json
  def create
    @destination_profile_action = DestinationProfileAction.new(destination_profile_action_params)

    respond_to do |format|
      if @destination_profile_action.save
        format.html { redirect_to @destination_profile_action, notice: 'Destination profile action was successfully created.' }
        format.json { render :show, status: :created, location: @destination_profile_action }
      else
        format.html { render :new }
        format.json { render json: @destination_profile_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /destination_profile_actions/1
  # PATCH/PUT /destination_profile_actions/1.json
  def update
    respond_to do |format|
      if @destination_profile_action.update(destination_profile_action_params)
        format.html { redirect_to @destination_profile_action, notice: 'Destination profile action was successfully updated.' }
        format.json { render :show, status: :ok, location: @destination_profile_action }
      else
        format.html { render :edit }
        format.json { render json: @destination_profile_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /destination_profile_actions/1
  # DELETE /destination_profile_actions/1.json
  def destroy
    @destination_profile_action.destroy
    respond_to do |format|
      format.html { redirect_to destination_profile_actions_url, notice: 'Destination profile action was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_destination_profile_action
      @destination_profile_action = DestinationProfileAction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def destination_profile_action_params
      params.require(:destination_profile_action).permit(:destination_profile_id, :application, :data)
    end
end
