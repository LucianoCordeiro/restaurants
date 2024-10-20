class MenusController < ApplicationController
  def index
    render json: {
      menus: Menu.where(restaurant: restaurant).map do |menu|
        {
          id: menu.id,
          name: menu.name
        }
      end
    }
  end

  def show
    menu = restaurant.menus.find(params[:id])

    render json: {
      menu: {
        id: menu.id,
        name: menu.name,
        menu_items: menu.menu_items.includes(:item).map do |menu_item|
          {
            name: menu_item.item.name,
            price: menu_item.price
          }
        end
      }
    }
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: 404
  end

  private

  def restaurant
    @restaurant ||= Restaurant.find(params[:restaurant_id])
  end
end
