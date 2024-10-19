require "rails_helper"

RSpec.describe Menu, type: :model do
  let(:restaurant) { FactoryBot.create(:restaurant) }

  it "must have a name" do
    menu = Menu.new(restaurant: restaurant)

    expect(menu.valid?).to be false
    expect(menu.errors.full_messages).to include "Name can't be blank"

    menu.name = "Sandwiches"

    expect(menu.valid?).to be true
  end

  it "must belong to a restaurant" do
    menu = Menu.new(name: "Sandwiches")

    expect(menu.valid?).to be false
    expect(menu.errors.full_messages).to include "Restaurant must exist"

    menu.restaurant = restaurant

    expect(menu.valid?).to be true
  end

  it "has many menu items" do
    hot_dishes = Menu.create(name: "Hot Dishes", restaurant: restaurant)
    cold_dishes = Menu.create(name: "Cold Dishes", restaurant: restaurant)

    kebab = Item.create(name: "Kebab")
    pasta = Item.create(name: "Pasta")
    salad = Item.create(name: "Salad")

    hot_kebab = MenuItem.new(price: 11.50, item: kebab)
    hot_pasta = MenuItem.new(price: 20.99, item: pasta)
    cold_salad = MenuItem.new(price: 8.79, item: salad)
    cold_kebab = MenuItem.new(price: 9.50, item: kebab)

    expect(hot_dishes.menu_items << hot_kebab).to include hot_kebab
    expect(hot_dishes.menu_items << hot_pasta).to include hot_pasta
    expect(cold_dishes.menu_items << cold_salad).to include cold_salad
    expect(cold_dishes.menu_items << cold_kebab).to include cold_kebab

    expect(hot_dishes.menu_items.count).to eql 2
    expect(cold_dishes.menu_items.count).to eql 2
  end
end
