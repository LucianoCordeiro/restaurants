class RestaurantDataProcessor
  def self.perform(params)
    logs = []

    ActiveRecord::Base.transaction do
      params[:restaurants].each do |e_restaurant|
        restaurant = Restaurant.find_or_create_by(name: e_restaurant[:name])

        e_restaurant[:menus].each do |e_menu|
          menu = restaurant.menus.find_or_create_by(name: e_menu[:name])

          (e_menu[:menu_items] || e_menu[:dishes]).each do |e_menu_item|
            item = Item.find_or_create_by(name: e_menu_item[:name])

            menu_item = menu.menu_items.create(item: item, price: e_menu_item[:price])

            logs << {
              menu_item: item.name,
              menu: menu.name,
              restaurant: restaurant.name,
              success: menu_item.valid?,
              errors: menu_item.errors.full_messages
            }
          end
        end
      end
    end

    logs
  end
end
