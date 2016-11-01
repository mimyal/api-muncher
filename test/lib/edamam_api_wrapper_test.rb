class EdamamApiWrapperTest < ActiveSupport::TestCase

#slack listchannels
  test "list_recipes returns array of recipes" do
    VCR.use_cassette("recipes") do
      recipes = EdamamApiWrapper.list_recipes
      puts recipes.first
      assert_kind_of Array, recipes
      recipes.each do |recipe|
        assert_kind_of Recipe, recipe
      end
    end
  end

  # test "listchannels returns array of channels" do
  #   VCR.use_cassette("channels") do
  #     channels = SlackApiWrapper.listchannels
  #     assert_kind_of Array, channels
  #     channels.each do |channel|
  #       assert_kind_of Channel, channel
  #     end
  #   end
  # end


# slackapi sendmsg
  # test "Can send a search query and get a valid response" do
  #   VCR.use_cassette("recipes") do
  #     search = "cilantro"
  #     response = EdamamApiWrapper.
  #   end
  #
  # end
    # test "Can send valid message to real channel" do
    #   VCR.use_cassette("channels") do
    #     message = "This is a test. One. Two. Three. End of testing."
    #     response = SlackApiWrapper.sendmsg("test-api-brackets", message)
    #     assert response["ok"]
    #     assert_equal response["message"]["text"], message
    #   end
    # end
    #
    # test "Can't send message to fake channel" do
    #   VCR.use_cassette("channels") do
    #     response = SlackApiWrapper.sendmsg("this-channel-does-not-exist", "test message")
    #     assert_not response["ok"]
    #     assert_not_nil response["error"]
    #   end
    # end
    #

end
