module RecipesHelper
  def link_selector(recipe)
    if recipe.url
      return recipe.url
    elsif recipe.uri
      return recipe.uri
    else
      return recipes_path
    end
  end
end
