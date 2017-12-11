require 'test_helper'
require 'factory_bot'

class ArtistsControllerTest < ActionDispatch::IntegrationTest

  test "should get show" do
    artist = create(:artist)
    get artist_url(artist)

    assert_response :success

  end

end
