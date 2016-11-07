module RecipesHelper
  def button_params(direction)
    return {page_direction: direction, q: params[:q], page: params[:page]}
  end


  # def link_selector(recipe)
  #   if recipe.url
  #     return recipe.url
  #   elsif recipe.uri
  #     return recipe.uri
  #   else
  #     return recipes_path
  #   end
  # end
end
