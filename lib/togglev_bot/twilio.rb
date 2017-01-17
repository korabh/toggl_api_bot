require "twilio-ruby"

module TogglevBot
  class Twilio
    def send_message(body)
      ::Twilio::REST::Client.new(
        "ACa5eac09ec84d0ab8565e4d1af98e724a",
        "1480787fefaa9f2c015725b0355a1b7c").messages.create(
        from: "+16178588544",
        to: "+37744690739",
        body: body
      )
    end
  end

end
