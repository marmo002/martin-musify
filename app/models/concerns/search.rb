class Search

  def initialize(search_term)
    @results = []
    @search_term = search_term
    populate_results_from_event
    populate_results_from_genres
    populate_results_from_venues
  end

  def results
    @results.flatten
  end

  def populate_results_from_event
    @results << Event.where("name ILIKE ?", "%#{@search_term}%")

  end

  def populate_results_from_genres
    genres = Genre.where("name ILIKE ?", "%#{@search_term}%")
    genres.each do |genre|
      genre.artists.each do |artist|
        @results << artist.events
      end
    end
  end
  def populate_results_from_venues
    venues = Venue.where("name ILIKE ?", "%#{@search_term}%")
    venues.each do |venue|
        @results << venue.events
    end
  end

  def search(search, parameter)
  end

end
