require 'test_helper'

class CompareControllerTest < ActionController::TestCase
  test "should get select_stops" do
    get :select_stops
    assert_response :success
  end

  test "should get select_routes" do
    get :select_routes
    assert_response :success
  end

  test "should get result" do
    get :result
    assert_response :success
  end

end
