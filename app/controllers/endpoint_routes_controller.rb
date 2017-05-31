class EndpointRoutesController < ApplicationController
  before_action :set_endpoint_route, only: [:show, :edit, :update, :destroy]

  # GET /endpoint_routes
  # GET /endpoint_routes.json
  def index
    authorize! :read, :endpoint_routes
    @endpoint_routes = EndpointRoute.order(position: :asc).page(params[:page]).all
  end

  # GET /endpoint_routes/1
  # GET /endpoint_routes/1.json
  def show
    authorize! :read, :endpoint_routes
  end

  # GET /endpoint_routes/new
  def new
    authorize! :create, :endpoint_routes
    @endpoint_route = EndpointRoute.new
    @endpoint_route.outbound_routes.build
  end

  # GET /endpoint_routes/1/edit
  def edit
    authorize! :update, :endpoint_routes
  end

  # POST /endpoint_routes
  # POST /endpoint_routes.json
  def create
    authorize! :create, :endpoint_routes
    @endpoint_route = EndpointRoute.new(endpoint_route_params)

    respond_to do |format|
      if @endpoint_route.save
        format.html { redirect_to @endpoint_route, notice: 'Endpoint route was successfully created.' }
        format.json { render :show, status: :created, location: @endpoint_route }
      else
        format.html { render :new }
        format.json { render json: @endpoint_route.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /endpoint_routes/1
  # PATCH/PUT /endpoint_routes/1.json
  def update
    authorize! :update, :endpoint_routes
    respond_to do |format|
      if @endpoint_route.update(endpoint_route_params)
        format.html { redirect_to @endpoint_route, notice: 'Endpoint route was successfully updated.' }
        format.json { render :show, status: :ok, location: @endpoint_route }
      else
        format.html { render :edit }
        format.json { render json: @endpoint_route.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /endpoint_routes/1
  # DELETE /endpoint_routes/1.json
  def destroy
    authorize! :delete, :endpoint_routes
    @endpoint_route.destroy
    respond_to do |format|
      format.html { redirect_to endpoint_routes_url, notice: 'Endpoint route was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_endpoint_route
      @endpoint_route = EndpointRoute.from_user(current_user).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def endpoint_route_params
      params.require(:endpoint_route).permit(:endpoint_id, :destination_number, :position, outbound_route_ids: [])

    end
end
