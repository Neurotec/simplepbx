class Resource::RecordsController < ApplicationController
  #play debe ser autenticable, puede ser por un token de session solo para reproducir
  skip_before_action :verify_authenticity_token, only: [:upload, :play]
  skip_before_action :authenticate_user!, only: [:upload, :play]
  
  before_action :set_resource_record, only: [:show, :edit, :update, :destroy]

  # GET /resource/records
  # GET /resource/records.json
  def index
    @resource_records = Resource::Record.order(created_at: :desc).page(params[:page]).all
  end

  # GET /resource/records/1
  # GET /resource/records/1.json
  def show
  end

  # GET /resource/records/new
  def new
    @resource_record = Resource::Record.new
  end

  # GET /resource/records/1/edit
  def edit
  end

  # POST /resource/records
  # POST /resource/records.json
  def create
    @resource_record = Resource::Record.new(resource_record_params)

    respond_to do |format|
      if @resource_record.save
        format.html { redirect_to @resource_record, notice: 'Record was successfully created.' }
        format.json { render :show, status: :created, location: @resource_record }
      else
        format.html { render :new }
        format.json { render json: @resource_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /resource/records/1
  # PATCH/PUT /resource/records/1.json
  def update
    respond_to do |format|
      if @resource_record.update(resource_record_params)
        format.html { redirect_to @resource_record, notice: 'Record was successfully updated.' }
        format.json { render :show, status: :ok, location: @resource_record }
      else
        format.html { render :edit }
        format.json { render json: @resource_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resource/records/1
  # DELETE /resource/records/1.json
  def destroy
    @resource_record.destroy
    respond_to do |format|
      format.html { redirect_to resource_records_url, notice: 'Record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def play
    headers['content-type'] = 'audio/x-wav'
    record = Resource::Record.find(params[:id])
    send_file(record.path, type: 'audio/x-wav')
  end

  #POST upload
  def upload
    freeswitch = Freeswitch.find(params[:freeswitch_id])
    audio_io = params[:audio]
    record_path = Rails.root.join('resources', "#{SecureRandom.uuid}.wav")
    File.open(record_path, "wb").write(audio_io.read)
    Record.create!(freeswitch_id: freeswitch.id, path: record_path, name: 'record')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resource_record
      @resource_record = Resource::Record.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_record_params
      params.require(:resource_record).permit(:name)
    end
end
