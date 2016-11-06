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

  test "change_page can be called after self.search_results and should return an array of recipes" do
    VCR.use_cassette("hits") do
      # we already asserted this works
      clean_string = "cilantro"
      recipes = Recipe.search_results(clean_string)

      # test that this works to request the next set of recipes
      next_set_recipes = Recipe.change_page(1)
      assert_kind_of Array, next_set_recipes
      assert_not next_set_recipes.empty?
      next_set_recipes.each do |recipe|
        assert_kind_of Recipe, recipe
      end
      assert_not_equal(recipes, next_set_recipes)

      # test that this works to request the previous set of recipes (as in, the first 'recipes' in this test)
      previous_set_recipes = Recipe.change_page((-1))

      assert_kind_of Array, previous_set_recipes
      # assert_not previous_set_recipes.empty?
      # previous_set_recipes.each do |recipe|
        # assert_kind_of Recipe, recipe
      # end
      assert_equal(recipes, previous_set_recipes)
      assert_not_equal(next_set_recipes, previous_set_recipes)
    end
  end

  test "change_page should not allow page <1 and instead return current page" do
    VCR.use_cassette("hits") do
      # we already asserted this works
      clean_string = "cilantro"
      recipes = Recipe.search_results(clean_string)

      invalid_recipe_request = Recipe.change_page((-200))
      assert_equal(recipes, invalid_recipe_request)
    end
  end

# not implemented: will currently return: []
  # test "change_page should not allow page higher than total number of pages (listings total)%10" do
  #   assert false
  # end

  test "two different recipe objects with the same data should be equal" do
    recipe_a = Recipe.new(0, "Chocolate Ham", "ham.jpg", "http_string", "https_string", ["jam", "cheese"], ["Saturday night", "not for kids"])
    recipe_b = Recipe.new(0, "Chocolate Ham", "ham.jpg", "http_string", "https_string", ["jam", "cheese"], ["Saturday night", "not for kids"])

    assert_equal(recipe_a, recipe_b)
  end

end
