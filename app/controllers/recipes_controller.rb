# require 'EdamamApiWrapper'
# require 'recipe'

class RecipesController < ApplicationController

  def search
    if params["q"] != ""
      # SUCCESS
      search_string = recipe_params[:q]
      page = (recipe_params[:page] || 1).to_i
      @recipes = Recipe.search_results(search_string, page)
      # We have control over Recipe search results (in /lib)

      # raise
      # This will return an empty list if there are no search results from the API methods.
      # @todo Implement redirect to root for []
      render :index
      return

    # else
    end
    flash[:notice] = "Please enter a valid search term"
    redirect_to root_path
  end

  def show
    show_params = params[:uri]
    # Will stop some invalid recipes rather than showing an empty list
      @recipe = EdamamApiWrapper.get_recipe(show_params)
  end

private

def recipe_params
  params.permit(:q, :page)
end


end
