# tests first
class Recipe
  attr_reader :title, :image, :uri, :url, :clean_query

  def initialize(title, image, uri, url)
    @title = title
    @image = image
    @uri = uri
    @url = url
    # @clean_query = nil
  end

  def self.search_results(search_query, page=0)
    # clean up the search string first
    if search_query != nil
      @clean_query = search_query.split.first
      unless @clean_query == nil || @clean_query == "" || @clean_query.gsub!(/[^a-zA-Z]/, '')
        return EdamamApiWrapper.list_recipes(@clean_query, page)
      end
    end
    return nil
  end

end
