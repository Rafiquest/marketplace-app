require "test_helper"

class SellersControllerTest < ActionDispatch::IntegrationTest
  test "should get dashboard" do
    get sellers_dashboard_url
    assert_response :success
  end
end
