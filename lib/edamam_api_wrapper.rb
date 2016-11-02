require 'httparty'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  THE_KEY = ENV["EDAMAM_KEY"]
  THE_ID = ENV["EDAMAM_ID"]

  # attr_reader :data

  def self.list_recipes
    url = BASE_URL + "?q=#{search_string}" + "&app_id=#{THE_ID}&app_key=#{THE_KEY}"
    # url = BASE_URL + "?q=chicken" + "&app_id=#{THE_ID}&app_key=#{THE_KEY}"
    puts "URL: #{url}"
    data = HTTParty.get(url) #.parsed_response
    search_results = [] # was called the search_list
    if data["hits"]
      data["hits"].each do |hit|
        wrapper = Recipe.new(hit["recipe"]["label"], hit["recipe"]["image"], hit["recipe"]["url"])
        # label is recipe title
        # url is url for original recipe
        # image is image of recipe item
        search_results << wrapper
      end
    end
    return search_results
  end

  # BASE_URL = "https://slack.com/api/"
  # TOKEN = ENV["SLACK_TOKEN"]
  #
  # def self.listchannels()
  #   url = BASE_URL + "channels.list?" + "token=#{TOKEN}" + "&pretty=1&exclude_archived=1"
  #   data = HTTParty.get(url)
  #   channel_list = []
  #   if data["channels"]
  #     data["channels"].each do |channel|
  #       wrapper = Channel.new channel["name"], channel["id"] , purpose: channel["purpose"], is_archived: channel["is_archived"], members: channel["members"]
  #       channel_list << wrapper
  #     end
  #   end
  #   return channel_list
  # end
  #
  # def self.sendmsg(channel, msg, token = nil)
  #   puts "Sending message to channel #{channel}: #{msg}"
  #
  #   url = BASE_URL + "chat.postMessage?" + "token=#{TOKEN}"
  #   data = HTTParty.post(url,
  #   body:  {
  #     "text" => "#{msg}",
  #     "channel" => "#{channel}",
  #     "username" => "Goldie",
  #     "icon_emoji" => ":star2:",
  #     "as_user" => "false"
  #   },
  #   :headers => { 'Content-Type' => 'application/x-www-form-urlencoded' })
  # end

end
