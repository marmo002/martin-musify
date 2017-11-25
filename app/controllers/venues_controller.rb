class VenuesController < ApplicationController
  def index
    @venues = Venue.all

    respond_to do |format|
      format.html
      format.json do

        json_data = @venues.map do |venue|
          {
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

  def show
  end
end
