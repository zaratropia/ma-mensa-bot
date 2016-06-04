Rails.application.routes.draw do

  # Root route
  root 'daily_menus#from_open_mensa_api'

  # Resources
  resources :daily_menus

end
