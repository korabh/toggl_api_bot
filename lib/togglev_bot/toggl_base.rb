require "togglv8"
require "active_support/all"

module TogglevBot
  class TogglBase
    def initialize(api_token)
      @api_token = api_token
    end

    def toggl_file(extension=".pdf")
      str = ""
      str << "toggl-"
      str << Date.today.to_s(:db)
      str << "-"
      str << user["fullname"].split(" ").join("_").downcase
      str << "-#{extension}"
      str
    end

    private

    attr_reader :api_token

    def toggl
      @toggl ||= TogglV8::API.new(api_token)
    end
  end
end
