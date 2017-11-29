require 'test_helper'

class VenuesControllerTest < ActionDispatch::IntegrationTest
    test "should get index" do
        venue1 = create(:venue)
        get venues_url
        assert_response :success
      end
      
      test "should get show" do
        venue1 = create(:venue)
        get venue_url(venue1)
        assert_response :success
      end
end
