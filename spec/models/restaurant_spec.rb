require "rails_helper"

RSpec.describe Restaurant, type: :model do
  it "must have a name" do
    restaurant = Restaurant.new

    expect(restaurant.valid?).to be false
    expect(restaurant.errors.full_messages).to include "Name can't be blank"

    restaurant.name = "Subway"

    expect(restaurant.valid?).to be true
  end

  it "has many menus" do
    restaurant = Restaurant.create(name: "Subway")

    sandwiches = Menu.new(name: "Sandwiches")
    salads = Menu.new(name: "Salads")

    restaurant.menus << sandwiches
    restaurant.menus << salads

    expect(restaurant.menus).to include sandwiches
    expect(restaurant.menus).to include salads

    expect(restaurant.menus.count).to eql 2
  end
end
