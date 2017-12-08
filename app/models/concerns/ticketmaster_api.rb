class TicketmasterAPI

  def get_all_results
    if Rails.env.development?
      return $ticketmaster_api_result if $ticketmaster_api_result
      $ticketmaster_api_result = call_api
      return $ticketmaster_api_result
    else
      return call_api
    end
  end

  def call_api
    url = "https://app.ticketmaster.com/discovery/v2/events.json?apikey=#{ENV["TM_KEY"]}&city=Toronto&classificationName=music&size=200"
    @result = HTTParty.get(url)
    total_pages =  @result['page']['totalPages']
    page = 0
    response = []

    total_pages.times do
      @results = HTTParty.get("#{url}&page=#{page}")
      @parsed_results = JSON.parse(@results.body)
      response << @parsed_results['_embedded']['events']
      page += 1
    end
    return response
  end

  def create_artists
    response = get_all_results
    response.each do |page|
      page.each do |event|
        @event = event
        current_artist = event['_embedded']['attractions']
        genre = event['classifications'][0]['genre']
        next unless genre
        if current_artist && !Artist.find_by(artist_tm_id: current_artist[0]['id'])
          new_artist = Artist.create(
            name:             current_artist[0]['name'],
            artist_tm_id:     current_artist[0]['id'],
              )
              if Genre.find_by(name: event['classifications'][0]['genre']['name']).name == 'Undefined'
                new_artist.genres << Genre.find_by(name: 'Other')
              else
                new_artist.genres << Genre.find_by(name: event['classifications'][0]['genre']['name'])
              end
        end
      end
    end
  end

  def create_social
    response = get_all_results
    response.each do |page|
      page.each do |event|
          tm_artist = event['_embedded']['attractions']
          next unless tm_artist
          social_links = tm_artist[0]['externalLinks']
          artist = Artist.find_by(artist_tm_id: tm_artist[0]['id'])
          if tm_artist && social_links && artist
            add_socials(social_links, artist)
          end
      end
    end
  end

  def add_socials(social_links, artist)
    if social_links['homepage'] && !ArtistSocial.find_by(url: social_links['homepage'][0]['url'])
      new_website = ArtistSocial.create(
        name:             "website",
        url:              social_links['homepage'] &&
                          social_links['homepage'][0]['url'],
        artist_id:        artist.id
      )
    end
    if social_links['twitter'] && !ArtistSocial.find_by(url: social_links['twitter'][0]['url'])
      new_twitter = ArtistSocial.create(
        name:             "twitter",
        url:              social_links['twitter'] &&
                          social_links['twitter'][0]['url'],
        artist_id:        artist.id
      )
    end
    if social_links['youtube'] && !ArtistSocial.find_by(url: social_links['youtube'][0]['url'])
      new_youtube = ArtistSocial.create(
        name:             "youtube",
        url:              social_links['youtube'] &&
                          social_links['youtube'][0]['url'],
        artist_id:        artist.id
      )
    end
    if social_links['facebook'] && !ArtistSocial.find_by(url: social_links['facebook'][0]['url'])
      new_facebook = ArtistSocial.create(
        name:             "facebook",
        url:              social_links['facebook'] &&
                          social_links['facebook'][0]['url'],
        artist_id:        artist.id
      )
    end
    if social_links['instagram'] && !ArtistSocial.find_by(url: social_links['instagram'][0]['url'])
      new_instagram = ArtistSocial.create(
        name:             "instagram",
        url:              social_links['instagram'] &&
                          social_links['instagram'][0]['url'],
        artist_id:        artist.id
      )
    end
  end



  def create_venues
    response = get_all_results
    response.each do |page|
      page.each do |event|
        current_venue = event['_embedded']['venues'][0]
        if !Venue.find_by(venue_tm_id: current_venue['id'])
          new_venue = Venue.create(
            name:         current_venue['name'],
            address_1:    current_venue['address']['line1'],
            address_2:    current_venue['address']['line2'],
            city:         current_venue['city']['name'],
            province:     current_venue['state']['name'],
            postal_code:  current_venue['postalCode'],
            country:      current_venue['country']['name'],
            phone_number: current_venue['boxOfficeInfo'] && current_venue['boxOfficeInfo']['phoneNumberDetail'],
            venue_tm_id:  current_venue['id'],
            full_address:  "#{current_venue['address']['line1']}, #{current_venue['city']['name']}, #{current_venue['state']['name']}, #{current_venue['postalCode']}",
          )
        end
      end
    end
  end

  def create_genres
    response = get_all_results
    response.each do |page|
      page.each do |event|
        current_genre = event['classifications'][0]['genre']
        if current_genre && !Genre.find_by(name: current_genre['name'])
          new_genre = Genre.create(
            name:        current_genre['name'],
            genre_tm_id: current_genre['id']
          )
        end
      end
    end
  end

  def create_events
    response = get_all_results
    response.each do |page|
      page.each do |event|

        venue_tm_id = event['_embedded']['venues'][0]['id']
        artist_tm_id = event['_embedded']['attractions'] && event['_embedded']['attractions'][0]['id']
        venue = venue_tm_id ? Venue.find_by(venue_tm_id: venue_tm_id) : nil
        artist = artist_tm_id ? Artist.find_by(artist_tm_id: artist_tm_id) : nil

        if !Event.find_by(event_tm_id: event['id'])
            new_event = Event.create(
            venue:       venue,
            artist:      artist,
            name:        event['name'],
            event_tm_id: event['id'],
            date:        event['dates']['start']['dateTime'],
          )
          # unless new_event.persisted?
          #   binding.pry
          # end
        end
      end
    end
  end

  def create_event_images
    response = get_all_results
    response.each do |page|
      page.each do |event|

        event_tm_id = event['id']
        current_event = event_tm_id ? Event.find_by(event_tm_id: event_tm_id) : nil

          event['images'].each do |image|
            new_image = Image.create!(
              url:   image['url'],
              ratio: image['ratio'],
              event: current_event
            )
            puts "#{new_image} created"
          end
      end
    end
  end

  def create_venue_images
    response = get_all_results
    response.each do |page|
      page.each do |event|

        venue_tm_id = event['_embedded']['venues'][0]['id']
        current_venue = venue_tm_id ? Venue.find_by(venue_tm_id: venue_tm_id) : nil

        if event['_embedded']['venues'][0]['images']
          event['_embedded']['venues'][0]['images'].each do |image|
            new_image = VenueImage.create!(
              url:   image['url'],
              ratio: image['ratio'],
              venue: current_venue
            )
          end
        end
      end
    end
  end

  def create_db
    create_genres
    create_artists
    create_social
    create_venues
    create_venue_images
    create_events
    create_event_images
  end
  def destroy_db
    Artist.destroy_all
    ArtistSocial.destroy_all
    Venue.destroy_all
    VenueImage.destroy_all
    Genre.destroy_all
    Event.destroy_all
    Image.destroy_all
  end

  def destroy_and_create_db
    destroy_db
    create_db
    nil
  end

end
