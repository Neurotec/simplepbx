class UserGroupsController < ApplicationController
  before_action :set_user_group, only: [:show, :edit, :update, :destroy]

  # GET /user_groups
  # GET /user_groups.json
  def index
    authorize! :read, :user_groups
    @user_groups = UserGroup.all
  end

  # GET /user_groups/1
  # GET /user_groups/1.json
  def show
    authorize! :read, :user_groups
  end

  # GET /user_groups/new
  def new
    authorize! :create, :user_groups
    @user_group = UserGroup.new
  end

  # GET /user_groups/1/edit
  def edit
    authorize! :update, :user_groups
  end

  # POST /user_groups
  # POST /user_groups.json
  def create
    authorize! :create, :user_groups
    @user_group = UserGroup.new(user_group_params)

    respond_to do |format|
      if @user_group.save
        format.html { redirect_to @user_group, notice: 'User group was successfully created.' }
        format.json { render :show, status: :created, location: @user_group }
      else
        format.html { render :new }
        format.json { render json: @user_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_groups/1
  # PATCH/PUT /user_groups/1.json
  def update
    authorize! :update, :user_groups
    respond_to do |format|
      if @user_group.update(user_group_params)
        format.html { redirect_to @user_group, notice: 'User group was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_group }
      else
        format.html { render :edit }
        format.json { render json: @user_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_groups/1
  # DELETE /user_groups/1.json
  def destroy
    authorize! :delete, :user_groups
    @user_group.destroy
    respond_to do |format|
      format.html { redirect_to user_groups_url, notice: 'User group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_group
      @user_group = UserGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_group_params
      params.require(:user_group).permit(:name, :group_permissions_id)
    end
end
