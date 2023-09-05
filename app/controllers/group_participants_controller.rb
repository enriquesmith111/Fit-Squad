class GroupParticipantsController < ApplicationController
  def index
    @group_participant = GroupParticpant.all
  end

  def show
    @group_participant = GroupParticipant.find(params[:id])
    if @group_participant.user_id == current_user.id
      @group_participant.destroy
      redirect_to groups_path, notice: "You have left the group."
    else
      redirect_to groups_path, alert: "You are not authorized to leave this group."
    end
  end

  def new
    @group_participant = GroupParticipant.new
  end

  def create
    group_id = params[:group_participant][:group_id] # Adjust this based on your form field name

    # Find the group based on group_id
    @group = Group.find(group_id)
    @group_participant = GroupParticipant.new(user_id: current_user.id, group_id: group_id)

    if @group_participant.save
      redirect_to group_path(@group), notice: "Successfully joined the group!"
    else
      redirect_to group_path(@group)
    end
  end

  def update
    @group = Group.find(params[:group_id])
    @group_participant = GroupParticipant.find(params[:id])

    if @group_participant.update(group_participant_params)
      redirect_to group_path(@group)
    else
      render 'groups/show' # Render the show page with errors if the update fails
    end
  end

end
