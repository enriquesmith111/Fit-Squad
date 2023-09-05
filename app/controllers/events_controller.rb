class EventsController < ApplicationController
    def index
        @events = Event.all
        date = params[:date]

        # Check if the date is present
        if date.present?
          # The date is present, so filter the events by date
          @events = @events.where(date: date)
        else
          # The date is not present, so do not filter the events
          @events = Event.all
        end
        

        # The `geocoded` scope filters only flats with coordinates
        @markers = @events.geocoded.map do |event|
    {
        lat: event.latitude,
        lng: event.longitude
    }
        end
    end
    
    def show
        @event = Event.find(params[:id])
    end
    
    def new
        @event = Event.new
    end
    
    def create
        @event = Event.new(event_params)
        @event.user = current_user
        # Upload images to Cloudinary and associate their URLs with the yacht
        @event.event_image = Cloudinary::Uploader.upload(params[:event][:event_image].tempfile)
    
        if @event.save!
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
