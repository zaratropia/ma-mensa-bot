class BotWorker
  include Sidekiq::Worker
  include OpenMensa

  def perform
    token = '228539999:AAFBC-Ea2hC9E2OdFED02p6_8HOw_J0HxHw'

    Telegram::Bot::Client.run(token) do |bot|
      bot.listen do |message|
        case message.text
        when '/start'
          bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
        when '/stop'
          bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
        end
        when  '/essen'
          bot.api.send_message(chat_id: message.chat.id, text: get_meal_content_from_api)
        end
      end
    end

    def get_meal_content_from_api
      api_helper = OpenMensa::Api.new

      @data = JSON.parse api_helper.meal_list
      if @data.code = "404"
        message = "Für heute sind leider (noch) keine Daten verfübgar."
      else
        message = @data.body
      end
      message
    end
  end
end
