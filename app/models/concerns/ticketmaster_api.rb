class TicketmasterAPI

  def get_all_results
    url = "https://app.ticketmaster.com/discovery/v2/events.json?apikey=SezXKF8hYiQwriEyIirXVxqAoQO1KQLw&city=Toronto&classificationName=music&size=200"
    @result = HTTParty.get(url)
    total_pages =  @result['page']['totalPages']
    page = 0
    @response = []

    total_pages.times do
      @results = HTTParty.get("#{url}&page=#{page}")
      @parsed_results = JSON.parse(@results.body)
      @response << @parsed_results['_embedded']['events']
      page += 1
    end
    return @response
  end

  def create_artists
    @response = get_all_results
    @response.each do |page|
      page.each do |event|
        if event['_embedded']['attractions'] && !Artist.find_by(tm_id: event['_embedded']['attractions'][0]['id'])
          Artist.create(
            name: event['_embedded'] && event['_embedded']['attractions'][0]['name'],
            tm_id: event['_embedded'] && event['_embedded']['attractions'][0]['id'],
          )
        end
      end
    end
  end

  def create_venues
    @response = get_all_results
    @response.each do |page|
      page.each do |event|
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
      end
    end
  end

  def create_genres
    @response = get_all_results
    @response.each do |page|
      page.each do |event|
        if !Genre.find_by(tm_id: event['classifications'][0]['genre']['id'])
          Genre.create(
            name: event['classifications'][0]['genre']['name'],
            tm_id: event['classifications'][0]['genre']['id']
          )
        end
      end
    end
  end


  def create_events
    @response = get_all_results
    @response.each do |page|
      page.each do |event|
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

end
