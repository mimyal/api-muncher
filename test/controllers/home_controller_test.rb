require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get the index" do
    get :index
    assert_response :success
  end
end
