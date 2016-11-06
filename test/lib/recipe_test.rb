require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

  test "Recipe.search_results should return an array of recipes" do
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

  # test "different_page can be called after self.search_results and should return an array of recipes" do
  #   VCR.use_cassette("hits") do
  #     # we already asserted this works
  #     clean_string = "cilantro"
  #     working_recipes = Recipe.search_results(clean_string)
  #
  #     # test that this works to request the next set of recipes
  #     next_set_recipes = working_recipes.different_page(1)
  #     assert_kind_of Array, next_set_recipes
  #     assert_not next_set_recipes.empty?
  #     next_set_recipes.each do |recipe|
  #       assert_kind_of Recipe, recipe
  #     end
  #
  #     # test that this works to request the previous set of recipes
  #     previous_set_recipes = working_recipes.different_page((-1))
  #
  #     assert_kind_of Array, previous_set_recipes
  #     assert_not previous_set_recipes.empty?
  #     previous_set_recipes.each do |recipe|
  #       assert_kind_of Recipe, recipe
  #     end
  #   end
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
