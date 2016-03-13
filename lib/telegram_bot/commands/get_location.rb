module TelegramBot
  module Commands
    class GetLocation < Base
      def execute
        location = User.identity(message.from.id, message.chat.id).take.locations.last

        if location
          send_location(location)
        else
          say('No location')
        end
      end

    private
      def send_location(location)
        client_api.send_location(chat_id: chat_id, latitude: location.latitude, longitude: location.longitude)
      end
    end
  end
end
