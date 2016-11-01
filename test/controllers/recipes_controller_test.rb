require 'test_helper'

class RecipesControllerTest < ActionController::TestCase

  test "should get the index" do
    get :index
    assert_response :success
  end

# @todo once the API is set up
  test "the index must have access to recipes (instance variable)" do


    get :index


  end

end
