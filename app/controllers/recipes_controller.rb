# require 'EdamamApiWrapper'
# require 'recipe'

class RecipesController < ApplicationController

  def index
    search_string = recipe_params[:q]

    @recipes ||= Recipe.search_results(search_string, @listing)
  end

  def search
    if params["q"] != ""
      # SUCCESS
      search_string = recipe_params[:q]
      @recipes = Recipe.search_results(search_string)
      unless @recipes.empty?
        if @listing == nil
          @listing = 0
        elsif @listing >=0
          @listing +=10
        end
        render :index
        return
      end
    # else
    end
    flash[:notice] = "Please enter a valid search term"
    redirect_to root_path
  end

  def show
    show_params = params[:id]
    @recipe = Recipe.find(show_params)
    raise
  end

private

# undefined method `permit' for "cilantro":String
def recipe_params
  params.permit(:q)
end


end
