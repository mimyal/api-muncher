# tests first
class Recipe
  attr_reader :title, :image, :url

  def initialize(title, image, url)
    @title = title
    @image = image
    @url = url
  end

  def self.search_results(search_query)
    # clean up the search string
    clean_query = search_query.split.first.gsub(/[^a-zA-Z]/, '')
    return EdamamApiWrapper.list_recipes(clean_query)
  end

end
