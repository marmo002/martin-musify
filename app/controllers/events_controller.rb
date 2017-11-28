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
  def location
    # if session[:postal_code] == nil
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
