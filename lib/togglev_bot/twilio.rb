require "twilio-ruby"

module TogglevBot
  class Twilio
    def send_message(body)
      ::Twilio::REST::Client.new(
        "ACXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", 
        "your_auth_token").messages.create(
        from: "+161",
        to: "+38649",
        body: body
      )
    end
  end

end
