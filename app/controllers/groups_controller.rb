class GroupsController < ApplicationController
  def index
    @groups = Group.all
    end

  def show
    @group = Group.find(params[:id])
    @events = @group.events
    @admin = Group.find(params[:id]).user
    @group_participant = GroupParticipant.new
    @group_participants = GroupParticipant.where(group_id: @group.id)
    @existing_participant = @group_participants.find_by(user_id: current_user.id)
    @group_participant_count = @group_participants.count
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user
    # Upload images to Cloudinary and associate their URLs with the yacht
    @group.group_image = Cloudinary::Uploader.upload(params[:group][:group_image].tempfile)

    if @group.save!
      redirect_to groups_path
    else
      render :new
    end
  end
  def destroy
    @group = Group.find(params[:id])
  if @group.user_id == current_user.id
      if @group.destroy
        redirect_to groups_path, notice: "You have deleted the group."
      else
        redirect_to groups_path, alert: "Failed to delete the group."
      end
    else
      redirect_to groups_path, alert: "You are not authorized to delete this group."
    end
  end



  private

  def group_params
    params.require(:group).permit(:name, :description, :city, :group_image)
  end
end
