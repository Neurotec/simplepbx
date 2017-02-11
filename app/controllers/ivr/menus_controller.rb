class Ivr::MenusController < ApplicationController
  before_action :set_ivr_menu, only: [:refresh_remote, :show, :edit, :update, :destroy]

  # GET /ivr/menus
  # GET /ivr/menus.json
  def index
    @ivr_menus = Ivr::Menu.page(params[:page]).all
  end

  # GET /ivr/menus/1
  # GET /ivr/menus/1.json
  def show
  end

  # GET /ivr/menus/new
  def new
    @ivr_menu = Ivr::Menu.new
    5.times {
      @ivr_menu.ivr_actions.build
    }
  end

  # GET /ivr/menus/1/edit
  def edit
  end

  # POST /ivr/menus
  # POST /ivr/menus.json
  def create
    @ivr_menu = Ivr::Menu.new(ivr_menu_params)

    respond_to do |format|
      if @ivr_menu.save
        format.html { redirect_to ivr_menus_path, notice: 'Menu was successfully created.' }
        format.json { render :show, status: :created, location: @ivr_menu }
      else
        format.html { render :new }
        format.json { render json: @ivr_menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ivr/menus/1
  # PATCH/PUT /ivr/menus/1.json
  def update
    respond_to do |format|
      if @ivr_menu.update(ivr_menu_params)
        format.html { redirect_to ivr_menus_path, notice: 'Menu was successfully updated.' }
        format.json { render :show, status: :ok, location: @ivr_menu }
      else
        format.html { render :edit }
        format.json { render json: @ivr_menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ivr/menus/1
  # DELETE /ivr/menus/1.json
  def destroy
    @ivr_menu.destroy
    respond_to do |format|
      format.html { redirect_to ivr_menus_url, notice: 'Menu was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

    
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ivr_menu
      @ivr_menu = Ivr::Menu.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ivr_menu_params
      params.require(:ivr_menu).permit(:name, :freeswitch_id, :greet_long_id, :greet_short_id, :invalid_sound_id, :exit_sound_id, :timeout, :inter_digit_timeout, :max_failures,:digit_len, :menu_top_digits,
                                       ivr_actions_attributes: [:digits, :outbound_route_id, :id])
    end
end
