require 'active_support'
require 'i18n'

module TelegramBot
  module Commands
    class Base
      attr_reader :message, :chat_id, :telegram_user 

      def self.execute(*args)
        new(*args).execute
      end

      def initialize(message)
        @message = message

        @chat_id = message.chat.id
        @telegram_user = message.from
      end

      def execute
        fail NotImplementedError, 'You need to override this method first.'
      end

    private 
      def client_api
        TelegramBot::Client.client.api
      end

      def say(text)
        client_api.send_message(chat_id: chat_id, text: text)
      end
    end
  end
end
