require 'test_helper'

class CountiesControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get counties_search_url
    assert_response :success
  end

end
