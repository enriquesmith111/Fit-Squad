class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
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

  private

  def group_params
    params.require(:group).permit(:name, :description, :city, :group_image)
  end
end
