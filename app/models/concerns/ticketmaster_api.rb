class TicketmasterAPI
  def initialize
    @response = HTTParty.get('https://app.ticketmaster.com/discovery/v2/events.json?apikey=SezXKF8hYiQwriEyIirXVxqAoQO1KQLw&city=Toronto&classificationName=music&size=100')
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
      Artist.create(
        name: event['_embedded'] && event['_embedded']['attractions'][0]['name'],
        tm_id: event['_embedded'] && event['_embedded']['attractions'][0]['id'],
      )
      # rescue
      #   binding.pry
      # end

    end
  end

  def create_events
    events.each do |event|
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
