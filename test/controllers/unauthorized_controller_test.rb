require 'test_helper'

class UnauthorizedControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get unauthorized_show_url
    assert_response :success
  end

end
