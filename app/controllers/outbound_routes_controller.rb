class OutboundRoutesController < ApplicationController
  respond_to :json
  def index
    @outbound_routes = OutboundRoute.where(freeswitch_id: params[:freeswitch_id]).order(foreign_class_name: :desc)
  end
end
