require 'test_helper'

class Time::NowControllerTest < ActionDispatch::IntegrationTest
  test "accepts html" do
    get time_now_url
    assert_response :success
    assert_equal "text/html; charset=utf-8", @response.content_type
  end
  test "accepts json" do
    get time_now_url(format: :json)
    assert_response :success
    assert_equal "application/json; charset=utf-8", @response.content_type
  end
  test "accepts xml" do
    get time_now_url(format: :xml)
    assert_response :success
    assert_equal "application/xml; charset=utf-8", @response.content_type
  end
  test "accepts txt" do
    get time_now_url(format: :txt)
    assert_response :success
    assert_equal "text/plain; charset=utf-8", @response.content_type
  end
end
