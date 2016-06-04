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
      menu_date = get_current_mensa_date
      puts menu_date
      self.class.get("/canteens/#{@id}/days/#{menu_date}/meals")
    end

    def canteens
      self.class.get("/canteens", @options)
    end

    private

    def get_current_mensa_date
      if Date.today.wday == 6
        menu_date = 2.days.from_now.strftime('%Y-%m-%d')
      elsif Date.today.wday == 0
        menu_date = 1.days.from_now.strftime('%Y-%m-%d')
      else
        menu_date = Date.today.strftime('%Y-%m-%d')
      end
      menu_date
    end

  end
end
