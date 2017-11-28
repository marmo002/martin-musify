require 'test_helper'
require 'factory_bot'

class EventsControllerTest < ActionDispatch::IntegrationTest
  
  test "should get index" do
    event = create(:event)
    get events_url
    assert_response :success
  end
  
  test "should get show" do
    event = create(:event)
    get event_url(event)
    assert_response :success
  end

end
