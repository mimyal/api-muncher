# require 'EdamamApiWrapper'
# require 'recipe'

class RecipesController < ApplicationController

  def index
    search_string = recipe_params[:q]
    if @page == nil
      @page = 0
    elsif @page >=0
      @page +=10
    end
    @recipes ||= Recipe.search_results(search_string, @page)
  end

  def search
    if params["q"] != ""
      # SUCCESS
      search_string = recipe_params[:q]
      @recipes = Recipe.search_results(search_string)
      unless @recipes.empty?
        render :index
        return
      end
    # else
    end
    flash[:notice] = "Please enter a valid search term"
    redirect_to root_path
  end

private

# undefined method `permit' for "cilantro":String
def recipe_params
  params.permit(:q)
end


end
