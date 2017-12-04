class VenuesController < ApplicationController
  def index
    @venues = Venue.all.page params[:page]

    respond_to do |format|
      format.html
      format.json do

        json_data = @venues.map do |venue|
          {
            "venueId": venue.id,
            "venueName": venue.name,
            "address_1": venue.address_1,
            "city": venue.city,
            "postal_code": venue.postal_code,
            "lat": venue.latitude,
            "lng": venue.longitude
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

  def show
    @venue = Venue.find(params[:id])

  end
end
