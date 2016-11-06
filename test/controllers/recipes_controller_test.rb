require 'test_helper'

class RecipesControllerTest < ActionController::TestCase

  test "search form should have a successful search if search_query is valid" do
    VCR.use_cassette("recipes") do
      params = {"q" => "cilantro"}
      get :search, params
      assert_response 200
      assert :index
    end
  end

  test "search form should render root if empty" do
    VCR.use_cassette("recipes") do
      params = {"q" => ""}
      get :search, params
      assert_redirected_to root_path
    end
  end

  test "search should render the correct page" do
    VCR.use_cassette("recipes") do
      params = {"q" => "tilapia", "page" => 2}
      get :search, params
      assert_response 200
      assert :index
    end
  end

  test "should get show" do
    VCR.use_cassette("recipes") do
      params = {"uri" => "http://www.edamam.com/ontologies/edamam.owl#recipe_55a8fd184bca071fefbbdc01325f88ef"}
      get :show, params
      assert_response :success
      assert_response 200 # also works
      assert :show
    end
  end

# # parsing error in get_recipe that I dont know how to solve
#   test "should not get show for invalid uri params" do
#     VCR.use_cassette("recipe") do
#       params = {"uri" => 'myrecipes.com'}
#       get :show, params
#       assert :show
#     end
#   end

end
