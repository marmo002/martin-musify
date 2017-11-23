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
        if event['_embedded']['attractions'] && !Artist.find_by(artist_tm_id: event['_embedded']['attractions'][0]['id'])
          new_artist = Artist.create(
            name: event['_embedded']['attractions'][0]['name'],
            artist_tm_id: event['_embedded']['attractions'][0]['id'],
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
            puts "#{new_artist.name} created"
        end
      end
    end
  end


  def create_venues
    @response = get_all_results
    @response.each do |page|
      page.each do |event|

        if !Venue.find_by(venue_tm_id: event['_embedded']['venues'][0]['id'])
          new_venue = Venue.create(
            name: event['_embedded']['venues'][0]['name'],
            address_1: event['_embedded']['venues'][0]['address']['line1'],
            address_2: event['_embedded']['venues'][0]['address']['line2'],
            city: event['_embedded']['venues'][0]['city']['name'],
            province: event['_embedded']['venues'][0]['state']['name'],
            postal_code: event['_embedded']['venues'][0]['postalCode'],
            country: event['_embedded']['venues'][0]['country']['name'],
            phone_number: event['_embedded']['venues'][0]['boxOfficeInfo'] && event['_embedded']['venues'][0]['boxOfficeInfo']['phoneNumberDetail'],
            venue_tm_id: event['_embedded']['venues'][0]['id']
          )
          puts "#{new_venue.name} created"
        end
      end
    end
  end

  def create_genres
    @response = get_all_results
    @response.each do |page|
      page.each do |event|
        if !Genre.find_by(genre_tm_id: event['classifications'][0]['genre']['id'])

          new_genre = Genre.create(
            name: event['classifications'][0]['genre']['name'],
            genre_tm_id: event['classifications'][0]['genre']['id']
          )
          puts "#{new_genre.name} created"
        end
      end
    end
  end


  def create_events
    @response = get_all_results
    @response.each do |page|
      page.each do |event|
      # begin
        venue_tm_id = event['_embedded']['venues'][0]['id']
        artist_tm_id = event['_embedded']['attractions'] && event['_embedded']['attractions'][0]['id']
        venue = venue_tm_id ? Venue.find_by(venue_tm_id: venue_tm_id) : nil
        artist = artist_tm_id ? Artist.find_by(artist_tm_id: artist_tm_id) : nil
        if !Event.find_by(event_tm_id: event['id'])
            new_event = Event.create(
            venue: venue,
            artist: artist,
            name: event['name'],
            event_tm_id: event['id'],
            date: event['dates']['start']['dateTime'],
          )
          puts "#{new_event.name} created"
        end
      # rescue
      #   binding.pry
      # end
      end
    end
  end

  def create_db
    create_artists
    create_venues
    create_genres
    create_events
  end
  def destroy_db
    Artist.destroy_all
    Venue.destroy_all
    Genre.destroy_all
    Event.destroy_all
  end

  def destroy_and_create_db
    destroy_db
    create_db
    nil
  end

end
