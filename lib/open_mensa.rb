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

      if @data.code == 404
        message = "Aktuell sind leider (noch) keine Daten verfübgar."
      else
        message = format_message JSON.parse(@data.body)
      end
      message
    end

    def meal_veggie
      @data = self.class.get("/canteens/#{@id}/days/#{current_mensa_date}/meals")

      if @data.code == 404
        message = "Für heute sind leider (noch) keine Daten verfübgar."
      else
        message = format_message JSON.parse(@data.body)
      end
      message # TODO extract veggie hash
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
      message << "<a href='https://www.stw-ma.de/Essen+_+Trinken/Mensen+_+Cafeterien/Mensa+Hochschule+Mannheim.html'>Mensa Hochschule Manheim</a>#{new_line}"
      message << "#{current_mensa_date}#{new_line}"
      hash.each do |h|
        message << "<b>#{h['notes']}</b>#{new_line}"
        message << "<pre>#{h['name']}</pre>#{new_line}"
      end
      message
    end

    def new_line
      "&#13;&#10"
    end

  end
end
