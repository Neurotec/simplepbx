class ExtensionGroupsController < ApplicationController
  before_action :set_extension_group, only: [:show, :edit, :update, :destroy]

  # GET /extension_groups
  # GET /extension_groups.json
  def index
    authorize! :read, :extension_groups
    @extension_groups = ExtensionGroup.page(params[:page]).all
  end

  # GET /extension_groups/1
  # GET /extension_groups/1.json
  def show
    authorize! :read, :extension_groups
  end

  # GET /extension_groups/new
  def new
    authorize! :create, :extension_groups
    @extension_group = ExtensionGroup.new
  end

  # GET /extension_groups/1/edit
  def edit
    authorize! :update, :extension_groups
  end

  # POST /extension_groups
  # POST /extension_groups.json
  def create
    authorize! :create, :extension_groups
    @extension_group = ExtensionGroup.new(extension_group_params)

    respond_to do |format|
      if @extension_group.save
        format.html { redirect_to @extension_group, notice: 'Extension group was successfully created.' }
        format.json { render :show, status: :created, location: @extension_group }
      else
        format.html { render :new }
        format.json { render json: @extension_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /extension_groups/1
  # PATCH/PUT /extension_groups/1.json
  def update
    authorize! :update, :extension_groups
    respond_to do |format|
      if @extension_group.update(extension_group_params)
        format.html { redirect_to @extension_group, notice: 'Extension group was successfully updated.' }
        format.json { render :show, status: :ok, location: @extension_group }
      else
        format.html { render :edit }
        format.json { render json: @extension_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /extension_groups/1
  # DELETE /extension_groups/1.json
  def destroy
    authorize! :delete, :extension_groups
    @extension_group.destroy
    respond_to do |format|
      format.html { redirect_to extension_groups_url, notice: 'Extension group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_extension_group
      @extension_group = ExtensionGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def extension_group_params
      params.require(:extension_group).permit(:extension_id, :group_id)
    end
end
