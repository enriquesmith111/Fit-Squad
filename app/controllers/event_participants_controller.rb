class EventParticipantsController < ApplicationController
  before_action :set_event
  before_action :set_event_participant, only: [:destroy]

  def new
    @group = Group.find(params[:group_id])
    @event = @group.events.find(params[:event_id])
    @event_participant = @event.event_participants.build
  end

  def index
    @participants = @event.participants
  end

  def create
    @event = Event.find(params[:event_id])
    @participant = EventParticipant.new(participant_params) # Create a new participant for the event

    if @participant.save
      redirect_to event_participants_path(@event), notice: 'Participant was successfully added.'
    else
      # Handle validation errors or other failure scenarios
      render :new
    end
  end



  def destroy
    @participant.destroy
    redirect_to event_participants_path(@event), notice: 'Participant was successfully removed.'
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_event_participant
    @participant = @event.participants.find(params[:id])
  end

end
