class RestaurantsController < ApplicationController
  def index
    render json: {
      restaurants: Restaurant.all.map do |restaurant|
        {
          id: restaurant.id,
          name: restaurant.name
        }
      end
    }
  end

  def show
    restaurant = Restaurant.find(params[:id])

    render json: {
      restaurant: {
        id: restaurant.id,
        name: restaurant.name,
        menus: restaurant.menus.map { |menu| { name: menu.name } }
      }
    }
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: 404
  end
end
