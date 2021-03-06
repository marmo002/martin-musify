class EventsController < ApplicationController
  protect_from_forgery only: %i(index show)

  def index
    if params[:search]
      @results = Search.new(params[:search]).results
      @events = Kaminari.paginate_array(@results).page(params[:page]).per(12)
    else
      @events = Event.all.page params[:page]
    end

  end

  def show
    @event = Event.find(params[:id])
    @venue = @event.venue
    respond_to do |format|
      format.html
      format.json do
        render json: {
          "venueName": @venue.name,
          "address_1": @venue.address_1,
          "city": @venue.city,
          "postal_code": @venue.postal_code,
          "lat": @venue.latitude,
          "lng": @venue.longitude,
        }
      end
    end
  end

  def new
    @event = Event.new
    require_login
  end

  def create
    date = Time.now
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      redirect_to events_url
    else
      flash[:alert] = "Please fill out the form"
      render :new
    end
  end

  def edit
      @event = Event.find(params[:id])
    if @event.user == logged_in? && current_user

    else
      redirect_to event_path(@event), alert: "You are not allowed to modify this event"
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to event_path(@event), alert: "#{@event.name} has been updated"
    else
      render 'edit', alert: "You must fix errors"
    end
  end

  def location
    if params[:postal_code]
      @location = params[:postal_code]
      session[:postal_code] = params[:postal_code]
      @geolocationObject = Geocoder.search(@location)
      @geolocation = @geolocationObject[0].data['geometry']['location']

      respond_to do |format|
        format.html
        format.json do
          render json: {
            "clientLocation": @geolocation
          }
        end
      end

    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :artist_id, :venue_id, :image)
  end

end
