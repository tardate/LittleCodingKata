require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get welcome_index_url
    assert_response :success
  end
  test "acts as root page" do
    get root_url
    assert_response :success
  end
end
