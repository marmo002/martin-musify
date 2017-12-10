class ArtistsController < ApplicationController

  def show
    @artist = Artist.find(params[:id])

    token = ENV["LASTFM_KEY"]

    response = HTTParty.get("http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&artist=#{@artist.name}&api_key=#{token}&format=json")
    body = JSON.parse(response.body)

    @src = body['artist']['image'][3]['#text']

  end
end
