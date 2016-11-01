require 'httparty'

class SlackApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  THE_KEY = ENV["EDAMAM_KEY"]
  THE_ID = ENV["EDAMAM_ID"]

  def self.list_recipes
# "https://api.edamam.com/search?q=chicken&app_id=${YOUR_APP_ID}&app_key=${YOUR_APP_KEY}"
# note that there are curly brackets above not in the variable below
    url = BASE_URL + "search.list?" + "_id=$#{THE_ID}&app_key=$#{THE_KEY}"
    data = HTTParty.get(url)
    search_list = []
    if data["search_results"]
      data["search_results"].each do |recipe|
        wrapper = Recipe.new(recipe["name"], recipe["id"], )
      end

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
