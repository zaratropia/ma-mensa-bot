module OpenMensa
  class Api
    include HTTParty
    require 'httparty'

    base_uri 'openmensa.org/api/v2'

    def initialize
      @id = 289 # OpenMensa ID
      @options = {  } # parameters
    end

    def hs_mannheim
      self.class.get("/canteens/#{@id}")
    end

    def meal_list
      @data = self.class.get("/canteens/#{@id}/days/#{current_mensa_date}/meals")
      puts @data.code
      if @data.code == 404
        message = "Für heute sind leider (noch) keine Daten verfübgar."
      else
        message = JSON.parse @data.body
      end
      format_message(message)
    end

    def canteens
      self.class.get("/canteens", @options)
    end

    private

    def current_mensa_date
      if Date.today.wday == 6
        menu_date = 2.days.from_now.strftime('%Y-%m-%d')
      elsif Date.today.wday == 0
        menu_date = 1.days.from_now.strftime('%Y-%m-%d')
      else
        menu_date = Date.today.strftime('%Y-%m-%d')
      end
      menu_date
    end

    def format_message(hash)
      message = ""
      message << "<a href='https://www.stw-ma.de/Essen+_+Trinken/Mensen+_+Cafeterien/Mensa+Hochschule+Mannheim.html'>Mensa Hochschule Manheim</a>"
      hash.each do |h|
        message << "<b>#{h['notes']}</b>"
        message << "<pre>#{h['name']}</pre>"
      end
      message
    end

  end
end
