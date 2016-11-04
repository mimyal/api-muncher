require 'test_helper'

class RecipesControllerTest < ActionController::TestCase

  test "search form should have a successful search if search_query is valid" do
    VCR.use_cassette("recipes") do
      params = {"q" => "cilantro"}
      get :search, params
      assert_response 200
      assert_template :index
    end
  end

  test "search form should render root if empty" do
    VCR.use_cassette("recipes") do
      params = {"q" => ""}
      get :search, params
      assert_redirected_to root_path
    end
  end

  test "if search query is invalid or there are no results it will return an empty array, and redirect_to root" do
    assert false
  end

  test "search should render the correct page" do
    VCR.use_cassette("recipes") do
      params = {"q" => "tilapia", "page" => 2}
      get :search, params
      assert
    end
  end

  # test "should get show" do
  #   VCR.use_cassette("recipes") do
  #     get :show, id: 0
  #     assert_response :success
  #   end
  # end

end
