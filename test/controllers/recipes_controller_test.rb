require 'test_helper'

class RecipesControllerTest < ActionController::TestCase

  test "should get the index" do
    VCR.use_cassette("recipes") do
      get :index
      assert_response :success
    end
  end

  test "search form should have a successful search if search_query is valid" do
    VCR.use_cassette("recipes") do
      params = {"q" => "cilantro"}
      get :search, params
      assert_response 200
      assert_template :index
    end
  end

  test "search form should not redirect to recipes#index if empty" do
    VCR.use_cassette("recipes") do
      params = {"q" => ""}
      get :search, params
      assert_redirected_to root_path
    end

  end

end
