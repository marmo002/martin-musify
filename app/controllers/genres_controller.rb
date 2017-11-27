class GenresController < ApplicationController
  def index
    @genres = Genre.all.order(:name)
  end

  def show
    @genre = Genre.find(params[:id])
    @events  = @genre.events

    respond_to do |format|
      format.html
      format.json do

        json_data = @events.map do |event|
          {
            "eventId": event.id,
            "eventName": event.name,
            "address_1": event.venue.address_1,
            "city": event.venue.city,
            "postal_code": event.venue.postal_code,
            "lat": event.venue.latitude,
            "lng": event.venue.longitude
          }
        end

        render json: json_data
      end
    end#respond_to


  end
end
