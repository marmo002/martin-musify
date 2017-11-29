require 'test_helper'

class AboutsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    skip
    get abouts_index_url
    assert_response :success
  end

end
