# tests first
class Recipe
  attr_reader :title, :image, :uri, :url, :ingredients, :diet_info, :listing_set

  def initialize(listing, title, image, uri, url, ingredients, dietary_info)
    @listing_set = listing
    @title = title
    @image = image
    @uri = uri
    @url = url
    @ingredients = ingredients
    @diet_info = dietary_info
  end

  def self.search_results(search_query, page=1)
    # cleaned up in wrapper
    @search_query = search_query
    @page = page
    return @recipes = EdamamApiWrapper.list_recipes(search_query, page)
  end

  def self.change_page(page_direction)
    if ((@page + page_direction) < 1)
      return @recipes
    else
      @page += page_direction
      return @recipes = EdamamApiWrapper.list_recipes(@search_query, @page)
    end
  end


# Method makes sure two recipe objects with the same content are the same
  def ==(another_recipe)
    return self.title == another_recipe.title && self.image == another_recipe.image && self.uri == another_recipe.uri && self.url == another_recipe.url && self.ingredients == another_recipe.ingredients && self.diet_info == another_recipe.diet_info
  end

end
