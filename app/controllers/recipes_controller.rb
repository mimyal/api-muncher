# require 'EdamamApiWrapper'
# require 'recipe'

class RecipesController < ApplicationController

  def search
    if params["q"] != ""
      # SUCCESS
      @query = recipe_params[:q]
      @page = (recipe_params[:page] || 1).to_i
      @recipes = Recipe.search_results(@query, @page)
      # We have control over Recipe search results (in /lib)

      # This will return an empty list if there are no search results from the API methods.
      # @todo Implement redirect to root for []
      render :index
      return
    # else
    end
    flash[:notice] = "Please enter a valid search term #{params[:q]}"
    redirect_to root_path
  end

  def show
    show_params = recipe_params[:uri]
    # Will stop some invalid recipes rather than showing an empty list
      @recipe = EdamamApiWrapper.get_recipe(show_params)
  end

  def more
    @query = recipe_params[:q]
    @page = (recipe_params[:page] || 2).to_i
    # @page = (recipe_params[:page] || 1).to_i
    more_direction = recipe_params[:page_direction].to_i
    # the Recipe class stops invalid page changes
    @recipes = Recipe.change_page(more_direction)
    if (@page + more_direction)>1
      @page += more_direction
      params[:page] = @page
    end
    # missing check for when there are no more recipes
    render :index
  end

private

def recipe_params
  params.permit(:q, :page, :uri, :page_direction)
end


end
