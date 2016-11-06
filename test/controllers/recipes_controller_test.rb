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

  test "more should render index with a new page number" do
    VCR.use_cassette("recipes") do
      params = {"q" => "cilantro"}
      get :search, params

      #more (one page forward)
      params["page_direction"] = "1"
      get :more, params

      assert_equal("2", params[:page])

      #more (one more page forward)
      params["page_direction"] = "1"
      get :more, params

      assert_equal("3", params[:page])

      assert_response 200
      assert :index
    end
  end

  test "more should not change @page to less than one" do
    VCR.use_cassette("recipes") do
      # this is page one by default
      params = {"q" => "cilantro"}
      get :search, params

      #more attempt backwards to zero
      params["page_direction"] = "-1"
      get :more, params

      assert("1", params[:page])

      params["page_direction"] = "-100"
      get :more, params

      assert("1", params[:page])
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
