class EventsController < ApplicationController

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
          "lng": @venue.longitude
        }
      end
    end
  end

  def new
    @event = Event.new
  end

  def create
    #code
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    #code
  end

end
