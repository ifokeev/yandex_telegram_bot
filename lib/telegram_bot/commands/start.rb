module TelegramBot
  module Commands
    class Start < Base
      def execute
        user = User.telegram(telegram_user.id).first_or_create do |obj|
          obj.first_name = telegram_user.first_name
          obj.last_name = telegram_user.last_name
        end

        hello_text = I18n.t('hello_text', user: telegram_user.first_name)
        say(hello_text)
      end
    end
  end
end
