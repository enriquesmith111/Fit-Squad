class EventParticipantsController < ApplicationController
  
  def event_path(event)
    # event_id is the ID of the event
    event_id = event.id
  
    # Generate the path to the event page
    path = "/events/#{event_id}"
  
    # Return the path
    return path
  end

  def index
    @event_participants = EventParticipant.all
  end

  def show
    @event = Event.find(params[:event_id])
    if @event.present?
      @event_participant = EventParticipant.find(params[:id])
      if @event_participant.user_id == current_user.id
        @event_participant.destroy
        redirect_to event_path(@event), notice: "You have left the event."
      else
        redirect_to event_path(@event), alert: "You are not authorized to leave this event."
      end
    else
      redirect_to events_path, alert: "Event not found."
    end
  end

  def new
    @event_participant = EventParticipant.new
  end

  def create
    event_id = params[:event_participant][:event_id] # Adjust this based on your form field name

    @event = Event.find(event_id)
    @event_participant = EventParticipant.new(user_id: current_user.id, event_id: event_id)

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

  def destroy
    @event_participant = EventParticipant.find(params[:id])
  
    if current_user == @event_participant.user
      @event_participant.destroy
      redirect_to event_path(@event), notice: "Successfully left the event!"
    else
      redirect_to event_path(@event), alert: "You can't leave this event."
    end
  end

  def event_participant_params
    params.require(:event_participant).permit(:user_id, :event_id)
  end
end
