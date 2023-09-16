class EventsController < ApplicationController
  def index
    @events = Event.all
    date = params[:date]

    # Check if the date is present
    if date.present?
      # The date is present, so filter the events by date
      @events = @events.where(date:)
    else
      # The date is not present, so do not filter the events
      @events = Event.all
    end

    # The `geocoded` scope filters only flats with coordinates
    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { event: })
      }
    end
  end

  def show
    @event = Event.find(params[:id])
    # @admin = User.where(@event)
    @event_participant = EventParticipant.new
    @event_participants = EventParticipant.where(event_id: @event.id)
    @existing_participant = @event_participants.find_by(user_id: current_user.id)
    @event_participant_count = @event_participants.count
    @chatroom = @event.chatroom
    # @chatroom.name = @event.name
    @message = Message.new
    @message.chatroom = @chatroom
    @markers = [
      {
        lat: @event.latitude,
        lng: @event.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { event: @event })
        # marker_html: render_to_string(partial: "marker")
      }
    ]
  end

  def new
    @group = Group.find(params[:group_id])
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.event_image = Cloudinary::Uploader.upload(params[:event][:event_image].tempfile)
    @event.group = Group.find(params[:group_id])
    if @event.save
      redirect_to group_event_path(@event.group, @event)
    else
      render :new
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to events_path
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :address, :date, :time, :event_image, :group_id, :activity_id)
  end

  def find_event
    @event = Event.find(params[:id])
  end
end
