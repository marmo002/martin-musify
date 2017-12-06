class GenresController < ApplicationController
  before_action :require_login, only: :favourite

  def index
    @genres = Genre.all
  end

  def show
    @genre = Genre.find(params[:id])
    @events = @genre.events.page params[:page]

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
    end
  end

  def location
    if params[:postal_code]
      @location = session[:postal_code]
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

  def favourite
    @genre = Genre.find(params[:id])
    @user = current_user
    @genre.users << @user
    # redirect_to user_path(current_user), notice: "You have favourite #{@genre.name}"
  end
end
