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

  test "search_results should return an empty array if the search_query is not valid" do
    numbers_string = "1234"
    empty_string = ""
    nil_that_should_be_a_string = nil

    assert_equal([], Recipe.search_results(numbers_string))
    assert_equal([], Recipe.search_results(empty_string))
    assert_equal([], Recipe.search_results(nil_that_should_be_a_string))
  end

#show
  # test "find should be able to find the instance recipe with specified id" do
  #   # params_id = 0
  #   # assert_instance_of Recipe, Recipe.find(params_id)
  # end

  test "two different recipe objects with the same data should be equal" do
    recipe_a = Recipe.new(0, "Chocolate Ham", "ham.jpg", "http_string", "https_string", ["jam", "cheese"], ["Saturday night", "not for kids"])
    recipe_b = Recipe.new(0, "Chocolate Ham", "ham.jpg", "http_string", "https_string", ["jam", "cheese"], ["Saturday night", "not for kids"])

    assert_equal(recipe_a, recipe_b)
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
