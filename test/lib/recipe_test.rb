require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

  test "Recipe.search_results should return an array of recipes with a given search_query" do
    VCR.use_cassette("hits") do
      clean_string = "cilantro"
      recipes = Recipe.search_results(clean_string)
      assert_kind_of Array, recipes
      assert_not recipes.empty?
      recipes.each do |recipe|
        assert_kind_of Recipe, recipe
      end
    end
  end

  test "search_results should return nil if the search_query is not valid" do
    numbers_string = "1234"
    empty_string = ""
    nil_that_should_be_a_string = nil

    assert_nil(Recipe.search_results(numbers_string))
    assert_nil(Recipe.search_results(empty_string))
    assert_nil(Recipe.search_results(nil_that_should_be_a_string))
  end


# #search_results returns the information needed for this application only, we can't test this because I am not asking for query information in my API request
#   test "search_results should return the results for the first word in a query" do
#     VCR.use_cassette("hits") do
#       search_query = "cilantro, edamame and caramel"
#       response = Recipe.search_results(search_query)
#
#       assert false
#       # assert_equal(response["q"], "cilantro")
#     end
#   end
end
