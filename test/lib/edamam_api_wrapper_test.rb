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

  test "list_recipes returns an empty array if the query has no results back from the API" do
    VCR.use_cassette("recipes") do
      query = "automobile"
      recipes = EdamamApiWrapper.list_recipes(query)
      assert_equal([], recipes)
    end
  end

  test "get_recipe should successfully return correct recipe" do
    VCR.use_cassette("recipes") do
      uri = 'http://www.edamam.com/ontologies/edamam.owl#recipe_c468dc28f8b64bb711125cc150b15c25'
      actual_recipe = EdamamApiWrapper.get_recipe(uri)

      expected_recipe = Recipe.new(0, 'Grilled Deviled Chickens Under a Brick', 'https://www.edamam.com/web-img/5f5/5f51c89f832d50da84e3c05bef3f66f9.jpg', uri, 'http://www.marthastewart.com/recipe/grilled-deviled-chickens-under-a-brick', ['4 baby chickens (poussins) or cornish hens (about 1 1/4 pounds each), or 4 chicken breast halves', '3 lemons, plus wedges for garnish', '4 cloves garlic, peeled and smashed', '1 tablespoon crushed red-pepper flakes, or to taste', '1 tablespoon finely chopped fresh thyme', '1 tablespoon finely chopped fresh rosemary', '1/2 cup olive oil', 'Salt, to taste'], ['Low-Carb'])

      assert_equal(actual_recipe, expected_recipe)

    end
  end

  test "list_recipes page should return the listings from that page" do
    VCR.use_cassette("recipes") do
      search_string = "tilapia"
      page = 2
      recipes = EdamamApiWrapper.list_recipes(search_string, page)
      assert_equal('http://www.edamam.com/ontologies/edamam.owl#recipe_55a8fd184bca071fefbbdc01325f88ef', recipes.first.uri)
    end
  end

  test "get_recipe should return nil for unexpected uri requests" do
    VCR.use_cassette("recipes") do
      uri = 'http://www.edamam.com/ontologies/edamam.owl#recipe_myownuri'
      unexpected_uri_response = EdamamApiWrapper.get_recipe(uri)

      assert_nil unexpected_uri_response

    end
  end

  # test "get_recipe should return nil if the request to the API was unsuccessful" do
  #   VCR.use_cassette("recipes") do
  #     assert false
  #   end
  # end


  # # not implemented
  # # query_sanitation should return the recipes matching the first word in the string typed in
  # test "Can send a search query and get a valid response" do
  #   VCR.use_cassette("hits") do
  #     search_string = "cilantro"
  #     response = EdamamApiWrapper.query_sanitation(search_string)
  #     assert_equal(response, "cilantro") # because cilantro is the sanitized version of itself
  #   end
  # end

# dont know what to assert here to ensure it works
  # test "an argument value for listing will return a successful API request" do
  #   VCR.use_cassette("hits") do
  #     clean_string = "cilantro"
  #     listing = 30
  #     response = EdamamApiWrapper.list_recipes(clean_string, listing)
  #     puts "#{response}"
  #     assert response[200]
  #   end
  # end

end
