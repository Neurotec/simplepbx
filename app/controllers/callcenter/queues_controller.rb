class Callcenter::QueuesController < ApplicationController
  before_action :set_callcenter_queue, only: [:show, :edit, :update, :destroy]

  # GET /callcenter/queues
  # GET /callcenter/queues.json
  def index
    authorize! :read, :callcenter_queues
    @callcenter_queues = Callcenter::Queue.page(params[:page]).all
  end

  # GET /callcenter/queues/1
  # GET /callcenter/queues/1.json
  def show
    authorize! :read, :callcenter_queues
  end

  # GET /callcenter/queues/new
  def new
    authorize! :create, :callcenter_queues
    @callcenter_queue = Callcenter::Queue.new
  end

  # GET /callcenter/queues/1/edit
  def edit
    authorize! :update, :callcenter_queues
  end

  # POST /callcenter/queues
  # POST /callcenter/queues.json
  def create
    authorize! :create, :callcenter_queues
    @callcenter_queue = Callcenter::Queue.new(callcenter_queue_params)
    @callcenter_queue.freeswitch_id = nil unless current_user.freeswitches.pluck(:id).include?(@callcenter_queue.freeswitch.id)
    
    respond_to do |format|
      if @callcenter_queue.save
        format.html { redirect_to @callcenter_queue, notice: 'Queue was successfully created.' }
        format.json { render :show, status: :created, location: @callcenter_queue }
      else
        format.html { render :new }
        format.json { render json: @callcenter_queue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /callcenter/queues/1
  # PATCH/PUT /callcenter/queues/1.json
  def update
    authorize! :update, :callcenter_queues
    @callcenter_queue.freeswitch_id = nil unless current_user.freeswitches.pluck(:id).include?(@callcenter_queue.freeswitch.id)
    respond_to do |format|
      if @callcenter_queue.update(callcenter_queue_params)
        format.html { redirect_to @callcenter_queue, notice: 'Queue was successfully updated.' }
        format.json { render :show, status: :ok, location: @callcenter_queue }
      else
        format.html { render :edit }
        format.json { render json: @callcenter_queue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /callcenter/queues/1
  # DELETE /callcenter/queues/1.json
  def destroy
    authorize! :delete, :callcenter_queues
    @callcenter_queue.destroy
    respond_to do |format|
      format.html { redirect_to callcenter_queues_url, notice: 'Queue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_callcenter_queue
      @callcenter_queue = Callcenter::Queue.from_user(current_user).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def callcenter_queue_params
      params.require(:callcenter_queue).permit(:name, :uuid, :strategy, :freeswitch_id, :callcenter_queue_profile_id)
    end
end
