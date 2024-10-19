require "rails_helper"

RSpec.describe MenuItem, type: :model do
  let(:menu) { FactoryBot.create(:menu) }
  let(:item) { FactoryBot.create(:item) }

  it "must have a price" do
    menu_item = MenuItem.new(menu: menu, item: item)

    expect(menu_item.valid?).to be false
    expect(menu_item.errors.full_messages).to include "Price can't be blank"

    menu_item.price = 10.76

    expect(menu_item.valid?).to be true
  end

  it "must belong to a menu" do
    menu_item = MenuItem.new(item: item, price: 10.76)

    expect(menu_item.valid?).to be false
    expect(menu_item.errors.full_messages).to include "Menu must exist"

    menu_item.menu = menu

    expect(menu.valid?).to be true
  end

  it "must belong to an item" do
    menu_item = MenuItem.new(menu: menu, price: 10.76)

    expect(menu_item.valid?).to be false
    expect(menu_item.errors.full_messages).to include "Item must exist"

    menu_item.item = item

    expect(menu.valid?).to be true
  end
end
