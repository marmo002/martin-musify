class TicketmasterAPI
  def initialize
    @response = HTTParty.get('https://app.ticketmaster.com/discovery/v2/events.json?apikey=SezXKF8hYiQwriEyIirXVxqAoQO1KQLw&city=Toronto&classificationName=music&size=50')
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
      if event['_embedded']['attractions']

        Artist.create(
        name: event['_embedded']['attractions'][0]['name'],
        tm_id: event['_embedded']['attractions'][0]['id'],
        website: event['_embedded']['attractions'] &&
        event['_embedded']['attractions'][0]['externalLinks'] &&
        event['_embedded']['attractions'][0]['externalLinks']['homepage'] &&
        event['_embedded']['attractions'][0]['externalLinks']['homepage'][0]['url'],
        twitter: event['_embedded']['attractions'] &&
        event['_embedded']['attractions'][0]['externalLinks'] &&
        event['_embedded']['attractions'][0]['externalLinks']['twitter'] &&
        event['_embedded']['attractions'][0]['externalLinks']['twitter'][0]['url'],
        youtube:  event['_embedded']['attractions'] &&
        event['_embedded']['attractions'][0]['externalLinks'] &&
        event['_embedded']['attractions'][0]['externalLinks']['youtube'] &&
        event['_embedded']['attractions'][0]['externalLinks']['youtube'][0]['url'],
        facebook:  event['_embedded']['attractions'] &&
        event['_embedded']['attractions'][0]['externalLinks'] &&
        event['_embedded']['attractions'][0]['externalLinks']['facebook'] &&
        event['_embedded']['attractions'][0]['externalLinks']['facebook'][0]['url'],
        instragram:  event['_embedded']['attractions'] &&
        event['_embedded']['attractions'][0]['externalLinks'] &&
        event['_embedded']['attractions'][0]['externalLinks']['instagram'] &&
        event['_embedded']['attractions'][0]['externalLinks']['instagram'][0]['url'],
        )
      end
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
