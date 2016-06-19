class BotWorker
  include Sidekiq::Worker
  include OpenMensa

  def perform
    token = '228539999:AAFBC-Ea2hC9E2OdFED02p6_8HOw_J0HxHw'

    Telegram::Bot::Client.run(token) do |bot|
      api_helper = OpenMensa::Api.new

      bot.listen do |message|
        case message.text
        #when '/start'
        #  bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
        #when '/stop'
        #  bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
        when '/essen'
          bot.api.send_message(chat_id: message.chat.id, text: api_helper.meal_list, parse_mode: 'HTML')
        end
      when '/veggie'
          bot.api.send_message(chat_id: message.chat.id, text: api_helper.meal_veggie, parse_mode: 'HTML')
        end
      end
    end
  end
end
