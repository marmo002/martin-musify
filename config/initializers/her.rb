Her::API.setup url: "https://app.ticketmaster.com/discovery/v2/events.json?apikey=SezXKF8hYiQwriEyIirXVxqAoQO1KQLw&city=Toronto" do |c|
  # Request
  c.use Faraday::Request::UrlEncoded

  # Response
  c.use Her::Middleware::DefaultParseJSON

  # Adapter
  c.use Faraday::Adapter::NetHttp
end

# need to setup the ticketmaster API
