class EdamamApiWrapperTest < ActiveSupport::TestCase

#slack equivalent listchannels
# this is for the greyed out version of list_recipes
# this test passes when search_query is inserted into list_recipes
  test "list_recipes returns array of recipes when it has a search string" do
    VCR.use_cassette("recipes") do
      clean_string = "cilantro"
      recipes = EdamamApiWrapper.list_recipes(clean_string)
      assert_kind_of Array, recipes
      recipes.each do |recipe|
        assert_kind_of Recipe, recipe
      end
    end
  end

  # slackapi sendmsg equivalent
  # query_sanitation should return the recipes matching the first word in the string typed in
  test "Can send a search query and get a valid response" do
    VCR.use_cassette("hits") do
      search_string = "cilantro"
      response = EdamamApiWrapper.query_sanitation(search_string)
      assert_equal(response, "cilantro") # because cilantro is the sanitized version of itself
    end
  end

# PUT THIS IN LATER
  # test "Will only return the search query using the first word letters from the search_query" do
  #   VCR.use_cassette("hits") do
  #     search_string = "cilantro, edamame and caramel"
  #     response = EdamamApiWrapper.search_query(search_string)
  #     assert_equal response["q"], "cilantro"
  #   end
  # end

  # test "Will not send a query for searches not starting on a letter character" do
  #   assert false
      # assert_nil true # ?
  # end
end
