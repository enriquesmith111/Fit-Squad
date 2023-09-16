class EventsController < ApplicationController
  def index
    @events = Event.includes(:event_participants).all
    @event_participant = EventParticipant.new
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
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    # Upload images to Cloudinary and associate their URLs with the yacht
    @event.event_image = Cloudinary::Uploader.upload(params[:event][:event_image].tempfile)

    @chatroom = Chatroom.new(name: @event.name) # Create a chatroom with the event's name
    @event.chatroom = @chatroom # Associate the chatroom with the event
    if @event.save && @chatroom.save
      redirect_to events_path
    else
      render :new
    end
  end

  private

  def group_params
    params.require(:event).permit(:name, :description, :address, :date, :time, :event_image)
  end
end
