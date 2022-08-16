class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: %i[ show edit update destroy join remove_member]
  
  # GET /groups or /groups.json
  def index
    if params[:show] == 'where_i_am_member'
      @groups = current_user.groups
    elsif params[:show] == 'created_by_me'
      @groups = Group.created_by_me(current_user)
    else
      @groups = Group.all_user_visible_groups(current_user)
    end
  end


  # GET /groups/1 or /groups/1.json
  def show
    @posts = @group.posts
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups or /groups.json
  def create
    @group = Group.new(group_params.merge(owner: current_user))

    respond_to do |format|
      if @group.save
        format.html { redirect_to group_url(@group), notice: "Group was successfully created." }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to group_url(@group), notice: "Group was successfully updated." }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url, notice: "Group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # POST /groups/1/join
  def join
    if !@group.members.include?(current_user) && current_user != @group.owner
      @group.members << current_user
      @group.save!

      redirect_to groups_url, notice: "You are welcome!"
    end
  end

  # POST /groups/1/remove_member
  def remove_member
    member_for_removing = User.find(params[:member_for_removing_id])
    if member_for_removing
      @group.members.delete(member_for_removing)
      redirect_to group_path, notice: "#{member_for_removing.email} are deleted from group!"
      @group.save!
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_params
      params.require(:group).permit(:name, :access)
    end
end
