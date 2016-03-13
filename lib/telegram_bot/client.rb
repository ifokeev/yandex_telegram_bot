require 'telegram/bot'
require_relative 'commands'

module TelegramBot
  class Client 
    TOKEN = '217512949:AAFj98AjW3b97PD77Wyp7EGrqyfRQFYvLDs' 

    class << self 
      def client
        @client ||= Telegram::Bot::Client.new(TOKEN)
      end

      def start_listen 
        puts "listening longpooling"

        client.listen do |message| 
          puts "new message"

          handle(message)
        end
      end

      def update(data)
        puts "new update"

        update = Telegram::Bot::Types::Update.new(data)

        update_id = update.update_id
        message = update.message
        message_id = message.message_id 

        handle(message)
      end

      def handle(message)
        TelegramBot::Message.handle(message)
      end
    end
  end
end
