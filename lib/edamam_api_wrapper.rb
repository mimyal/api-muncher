require 'httparty'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  THE_KEY = ENV["EDAMAM_KEY"]
  THE_ID = ENV["EDAMAM_ID"]

  attr_reader :data

  def self.list_recipes(clean_string)
    url = BASE_URL + "?q=#{clean_string}" + "&app_id=#{THE_ID}&app_key=#{THE_KEY}"
    # url = BASE_URL + "?q=chicken" + "&app_id=#{THE_ID}&app_key=#{THE_KEY}"
    puts "list_recipes URL: #{url}"
    @data = HTTParty.get(url) #.parsed_response
    search_results = [] # was called the search_list
    if @data["hits"]
      @data["hits"].each do |hit|
        wrapper = Recipe.new(hit["recipe"]["label"], hit["recipe"]["image"], hit["recipe"]["url"])
        # label is recipe title
        # url is url for original recipe
        # image is image of recipe item
        search_results << wrapper
      end
    end
    return search_results
  end

# restrictions on search queries @todo
  def self.query_sanitation(search_string)
    puts "Requesting #{search_string} from Edamam database"
    # Need to clean the string up
    clean_string = search_string
    # Used by the recipe controller action
    return clean_string
  end


end
