module TelegramBot
  class UserProxy 
    attr_reader :user

    def initialize(message_from, message_chat)
      @user = User.identity(message_from.id, message_chat.id).first_or_create do |obj|
        obj.first_name = message_from.first_name
        obj.last_name = message_from.last_name
      end
    end

    def location
      @user.locations.last
    end

    def state
      @user.state_item_key
    end

    def set_state(state)
      @user.state_item_key = state
      @user.save
    end

    def cart
      @user.cart
    end

    def clear_cart
      @user.cart.destroy!
    end

    def add_to_cart(item)
      cart.add_item(id: item.id, name: item.header, type: 'Product')
    end
  end
end

