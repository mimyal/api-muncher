# tests first
class Recipe
  attr_reader :title, :image, :uri, :url, :ingredients, :diet_info, :id #, :clean_query

  def initialize(listing, title, image, uri, url, ingredients, dietary_info)
    @id = listing
    @title = title
    @image = image
    @uri = uri
    @url = url
    @ingredients = ingredients
    @diet_info = dietary_info
    @clean_query = nil
  end

  # The RecipesController will send the listing number, but to remember what it means we call it page here and elsewhere
  def self.search_results(search_query, listing=0)
    # clean up the search string first
    if search_query != nil
      @clean_query = search_query.split.first
      unless @clean_query == nil || @clean_query == "" || @clean_query.gsub!(/[^a-zA-Z]/, '')
        return EdamamApiWrapper.list_recipes(@clean_query, listing)
      end
    end
    return nil
  end

# returns nil if no search query available or if the id is not in use
  def self.find(id)
    recipes = Recipe.search_results(@clean_query)
    recipes.each do |recipe|
      if recipe.id == id
        #SUCCESS
        return recipe
      end
    end
    return nil
  end

# Method makes sure two recipe objects with the same content are the same
  def ==(another_recipe)
    return self.title == another_recipe.title && self.image == another_recipe.image && self.uri == another_recipe.uri && self.url == another_recipe.url && self.ingredients == another_recipe.ingredients && self.diet_info == another_recipe.diet_info
  end

end
