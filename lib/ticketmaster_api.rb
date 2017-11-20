class TicketmasterAPI
  def initialize
    @response = HTTParty.get('https://app.ticketmaster.com/discovery/v2/events.json?apikey=SezXKF8hYiQwriEyIirXVxqAoQO1KQLw&city=Toronto')
  end

  def to_h
    JSON.parse(@response.body)
  end

  def events
    @response.to_h['_embedded']['events']
  end

  def create_events
    events.each do |event|
      puts "Creating #{event['name']}"
      Event.create(name: event['name'])
    end
  end

end
