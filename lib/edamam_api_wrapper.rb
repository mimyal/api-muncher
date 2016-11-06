require 'httparty'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  THE_KEY = ENV["EDAMAM_KEY"]
  THE_ID = ENV["EDAMAM_ID"]

  attr_reader :data

  def self.list_recipes(search_string, page=1)
    # clean up string
    clean_string = query_sanitation(search_string)
    if clean_string.empty?
      return []
    end
    #gives us the first ten

    listing = (page*10) - 10

    page_string = "&from=#{listing}"
    url = BASE_URL + "?q=#{clean_string}" + page_string + "&app_id=#{THE_ID}&app_key=#{THE_KEY}"
    # url = BASE_URL + "?q=chicken" + "&app_id=#{THE_ID}&app_key=#{THE_KEY}"
    # puts "list_recipes URL: #{url}"
    @data = HTTParty.get(url) #.parsed_response
    search_results = []
    if @data["hits"]
      @data["hits"].each do |hit|
        wrapper = Recipe.new(listing, hit["recipe"]["label"], hit["recipe"]["image"], hit["recipe"]["uri"], hit["recipe"]["url"], hit["recipe"]["ingredientLines"], hit["recipe"]["dietLabels"])
        # label is recipe title
        # image is image of recipe item
        # uri is uri for recipe on edamam
        # url is url for original recipe
        # "ingredientLines" is the array of ingredients
        # "dietLabels" is the array of dietary information
        search_results << wrapper
      end
    end
    return search_results
  end

# not implemented
# restrictions on search queries imposed by Edamam @todo
  def self.query_sanitation(search_string)
    # puts "Requesting #{search_string} from Edamam database"
    # Need to clean the string up
    if search_string.nil?
      return ''
    end
    clean_string = search_string.gsub(/[^a-zA-Z ]/, '')
    # Used by the recipe controller action
    return clean_string
  end

  def self.get_recipe(recipe_uri)
    url = BASE_URL + "?r=#{URI.encode(recipe_uri)}" + "&app_id=#{THE_ID}&app_key=#{THE_KEY}"
    @data = HTTParty.get(url).parsed_response
    if @data.empty?
      return nil
    else
      return Recipe.new(0, @data[0]['label'], @data[0]['image'], @data[0]['uri'], @data[0]['url'], @data[0]['ingredientLines'], @data[0]['dietLabels']  )
    end
  end

end
