class TicketmasterAPI
  def initialize
    @response = HTTParty.get('https://app.ticketmaster.com/discovery/v2/events.json?apikey=SezXKF8hYiQwriEyIirXVxqAoQO1KQLw&city=Toronto&classificationName=music&size=200')
  end

  def to_h
    JSON.parse(@response.body)
  end

  def events
    @events = @response.to_h['_embedded']['events']
  end

  def create_artists
    events.each do |event|
      # begin
      if event['_embedded']['attractions'] && !Artist.find_by(tm_id: event['_embedded']['attractions'][0]['id'])
        Artist.create(
          name: event['_embedded'] && event['_embedded']['attractions'][0]['name'],
          tm_id: event['_embedded'] && event['_embedded']['attractions'][0]['id'],
        )
      end
      # rescue
      #   binding.pry
      # end

    end
  end

  def create_venues
    events.each do |event|
      # begin
      if !Venue.find_by(tm_id: event['_embedded']['venues'][0]['id'])
        Venue.create(
          name: event['_embedded']['venues'][0]['name'],
          address_1: event['_embedded']['venues'][0]['address']['line1'],
          address_2: event['_embedded']['venues'][0]['address']['line2'],
          city: event['_embedded']['venues'][0]['city']['name'],
          province: event['_embedded']['venues'][0]['state']['name'],
          postal_code: event['_embedded']['venues'][0]['postalCode'],
          country: event['_embedded']['venues'][0]['country']['name'],
          phone_number: event['_embedded']['venues'][0]['boxOfficeInfo'] && event['_embedded']['venues'][0]['boxOfficeInfo']['phoneNumberDetail'],
          tm_id: event['_embedded']['venues'][0]['id']
        )
      end
      # rescue
      #   binding.pry
      # end
    end
  end

  def create_genres
    events.each do |event|
      # begin
      if !Genre.find_by(tm_id: event['classifications'][0]['genre']['id'])
        Genre.create(
          name: event['classifications'][0]['genre']['name'],
          tm_id: event['classifications'][0]['genre']['id']
        )
      end
      # rescue
      #   binding.pry
      # end
    end
  end


  def create_events
    events.each do |event|
      if !Event.find_by(tm_id: event['id'])
          Event.create(
          name: event['name'],
          tm_id: event['id'],
          date: event['dates']['start']['dateTime'],
          artist_id: event['_embedded']['attractions'] && event['_embedded']['attractions'][0]['id'],
          venue_id: event['_embedded']['venues'][0]['id']
        )
      end
    end
  end

end
