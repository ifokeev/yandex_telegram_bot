module TelegramBot
  class Reply
    attr_reader :message, :chat_id, :from 

    def self.for(message)
      new(message)
    end

    def initialize(message)
      @message = message

      @chat_id = message.chat.id
      @from = message.from
    end

    def text(text)
      client_api.send_message(chat_id: chat_id, text: text)
    end

    def text_with_keyboard(text, options)
      kb = Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: options, one_time_keyboard: true)

      client_api.send_message(chat_id: chat_id, text: text, reply_markup: kb)
    end
  private 
    def client_api
      TelegramBot::Client.client.api
    end
  end
end
