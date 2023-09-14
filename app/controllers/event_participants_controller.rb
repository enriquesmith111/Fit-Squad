class EventParticipantsController < ApplicationController
  def index
    @event_participant = EventParticpant.all
  end

  def show
    @event_participant = EventParticipant.find(params[:id])
    if @event_participant.user_id == current_user.id
      @group_participant.destroy
      redirect_to groups_path, notice: "You have left the group."
    else
      redirect_to groups_path, alert: "You are not authorized to leave this group."
    end
  end

  def new
    @event_participant = EventParticipant.new
  end

  def create
    event_id = params[:event_participant][:event_id] # Adjust this based on your form field name

    @event = Event.find(event_id)
    @event_participant = eventParticipant.new(user_id: current_user.id, event_id:)

    if @event_participant.save
      redirect_to event_path(@event), notice: "Successfully joined the event!"
    else
      redirect_to event_path(@event)
    end
  end

  def update
    @event = Event.find(params[:event_id])
    @event_participant = EventParticipant.find(params[:id])

    if @event_participant.update(event_participant_params)
      redirect_to event_path(@event)
    else
      render 'events/show' # Render the show page with errors if the update fails
    end
  end
end
