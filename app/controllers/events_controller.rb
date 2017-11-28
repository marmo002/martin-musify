class EventsController < ApplicationController
  protect_from_forgery only: %i(index show)

  def index
    @event = Event.new
    @events = Event.all

    if params[:search]
      @events = Search.new(params[:search]).results
    else
      @events = Event.all
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
    @location = params[:postal_code]
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
