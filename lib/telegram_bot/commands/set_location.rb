module TelegramBot
  module Commands
    class SetLocation < Base
      def execute
        location = message.location

        user = User.identity(message.from.id, message.chat.id)
          .take.locations.new(latitude: location.latitude, longitude: location.longitude)

        if user.save
          say(I18n.t('location.saved'))
        else
          say(I18n.t('location.not_saved'))
        end
      end
    end
  end
end
