require "rails_helper"

RSpec.describe RestaurantDataProcessor do
  it "process sample payload" do
    restaurants_hash = JSON.parse(file_fixture("restaurant_data.json").read).deep_symbolize_keys

    result = RestaurantDataProcessor.perform(restaurants_hash)

    expect(result).to eql(
      [
        {
          menu_item: "Burger",
          menu: "lunch",
          restaurant: "Poppo's Cafe",
          success: true,
          errors: []
        },
        {
          menu_item: "Small Salad",
          menu: "lunch",
          restaurant: "Poppo's Cafe",
          success: true,
          errors: []
        },
        {
          menu_item: "Burger",
          menu: "dinner",
          restaurant: "Poppo's Cafe",
          success: true,
          errors: []
        },
        {
          menu_item: "Large Salad",
          menu: "dinner",
          restaurant: "Poppo's Cafe",
          success: true, errors: []
        },
        {
          menu_item: "Chicken Wings",
          menu: "lunch",
          restaurant: "Casa del Poppo",
          success: true,
          errors: []
        },
        {
          menu_item: "Burger",
          menu: "lunch",
          restaurant: "Casa del Poppo",
          success: true,
          errors: []
        },
        {
          menu_item: "Chicken Wings",
          menu: "lunch",
          restaurant: "Casa del Poppo",
          success: false,
          errors: ["Item has already been taken"]
        },
        {
          menu_item: "Mega \"Burger\"",
          menu: "dinner",
          restaurant: "Casa del Poppo",
          success: true,
          errors: []
        },
        {
          menu_item: "Lobster Mac & Cheese",
          menu: "dinner",
          restaurant: "Casa del Poppo",
          success: true,
          errors: []
        }
      ]
    )
  end
end
