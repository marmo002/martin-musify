class EventsController < ApplicationController

  def index
    @event = Event.new
    @events = Event.all

    if params[:search]
      # all_results = []
      # all_results << @events = Event.search(params[:search]).order(created_at: :desc)
      # all_results << @artists = Artist.search(params[:search]).order(created_at: :desc)
      # all_results.flatten
      @events = Search.new(params[:search]).results
        # @events = Event.search(params[:search], "name")
        # @events = Event.artists.search(params[:search], "name").order(created_at: :desc)
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
          "lng": @venue.longitude
        }
      end
    end

  end
end
