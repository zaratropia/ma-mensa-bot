json.array!(@daily_menus) do |daily_menu|
  json.extract! daily_menu, :id, :body, :message
  json.url daily_menu_url(daily_menu, format: :json)
end
