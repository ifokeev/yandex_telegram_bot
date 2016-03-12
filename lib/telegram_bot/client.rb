require 'telegram/bot'
require_relative 'commands'

module TelegramBot
  class Client 
    TOKEN = '217512949:AAFj98AjW3b97PD77Wyp7EGrqyfRQFYvLDs' 

    class << self 
      def client
        @client ||= Telegram::Bot::Client.new(TOKEN)
      end

      def listen 
        puts "listening longpooling"

        client.listen do |message| 
          puts "new message"

          process(message)
        end
      end

      def update(data)
        puts "new update"

        update = Telegram::Bot::Types::Update.new(data)

        update_id = update.update_id
        message = update.message
        message_id = message.message_id 

        process(message)
      end

      def process(message)
        if message.location
          TelegramBot::Commands::SetLocation.execute(message)
          TelegramBot::Commands::GetLocation.execute(message)
        end

        case message.text
        when '/start'
          TelegramBot::Commands::Start.execute(message)

        when '/location'
          TelegramBot::Commands::GetLocation.execute(message)
        end
      end

    end
  end
end
