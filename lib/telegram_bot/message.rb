module TelegramBot
  class Message 
    attr_reader :user, :message, :reply

    def self.handle(message)
      new(message).handle
    end

    def initialize(message)
      @message = message
    end

    def handle
      @user = TelegramBot::UserProxy.new(message.from, message.chat)
      @reply = TelegramBot::Reply.for(message)

      if message.location
        TelegramBot::Commands::SetLocation.execute(message)
        # TelegramBot::Commands::GetLocation.execute(message)
      end

      state = retrieve_state(message.text)


      if state === 'order'
        make_order
      elsif state === 'confirm_order'

        if user.location.blank?
          text = %Q(
            Отправьте свою геопозицию, иначе я не завершу заказ, я же бот.
              )
        else
          text = %Q(
            Спасибо за заказ. ЛАЛАЛАЛ
          )
          user.clear_cart
          user.set_state('home')
        end

        reply.text(text)

      else
        release_reply_for_state(state)
      end
      # case message.text
      # when '/start'
      #   TelegramBot::Commands::Start.execute(message)
      #
      # when '/my_location'
      #   TelegramBot::Commands::GetLocation.execute(message)
      # end
      # reply.text("Your state #{state}")
    end

    def retrieve_state(message_text)
      user_state = user.state
      state = user_state

      case message_text
      when '/start'
        state = 'home'
        # options = [
        #   ['ХОЧУ ПИЦЦУ!!!111']
        # ]
        # reply.text_with_keyboard('Привет! Я пицца-бот. Что вы от меня хотите?', options)
      when '/help'
        state = 'home.help'
      when '/location'
        TelegramBot::Commands::GetLocation.execute(message)
      when '/order'
      when 'Оформить заказ'
        state = 'order'
      when '/confirm_order'
      when 'Подтвердить заказ'
      when 'Подтверждаю заказ'
        state = 'confirm_order'
      when '/empty_cart'
      when 'Очистить корзину'
        user.clear_cart
        state = 'home'
      else
        state_item = StateItem.find_by(header: message_text)
        if state_item && state_item.type === 'StateItem::Screen'
          state = state_item.path
        end

        if state_item && state_item.type === 'StateItem::Action'
          user.add_to_cart(state_item)
          state = 'order'
        end
      end

      if state != user_state
        user.set_state(state)
      end

      state
    end

    def make_order
      text = "Ваш заказ:\n"

      items = user.cart.items

      items.each_with_index do |item, index| 
        text << "#{index}) #{item.name} \n"
      end

      options = [
        ['Подтверждаю заказ'],
        ['Очистить корзину']
      ]

      reply.text_with_keyboard(text, options)
    end

    # def retrieve_screen_with_options(state)
    #   current_state = StateItem.object(state)
    #   next_depth = current_state.depth + 1
    #
    #   current_state_childs = StateItem.get_childs(state, next_depth) 
    #
    #   text = ''
    #
    #   text << current_state.description + "\n" if current_state.description
    #
    #   current_state_childs.each_with_index do |(key, value), index|
    #     text << "#{index}. #{value.header} \n"
    #   end
    #
    #   text = 'Не найдено описания' if text.empty?
    #   reply.text(text)
    # end

    def release_reply_for_state(state)
      current_state = StateItem.object(state)
      next_depth = current_state.depth + 1

      current_state_childs = StateItem.get_childs(state, next_depth) 

      text = ''
      options = []

      text << current_state.description + "\n" if current_state.description

      current_state_childs.each_with_index do |(key, value), index|
        text << "#{index}. #{value.header} \n"
        options << [value.header]
      end

      text = 'Не найдено описания' if text.empty?

      reply.text_with_keyboard(text, options)
    end

  end
end

