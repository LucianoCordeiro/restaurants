require 'rails_helper'

RSpec.describe MenusController, type: :request do
  let!(:menu) { FactoryBot.create(:menu) }
  let!(:item) { FactoryBot.create(:item) }
  let!(:menu_item) { MenuItem.create(menu: menu, item: item, price: 20.99) }

  it 'menu found' do
    get(
      "/restaurants/#{menu.restaurant.id}/menus/#{menu.id}"
    )

    expect(response.status).to eql 200
    expect(response.body).to eql(
      {
        menu: {
          id: menu.id,
          name: menu.name,
          menu_items: [
            {
              name: menu_item.item.name,
              price: menu_item.price
            }
          ]
        }
      }.to_json
    )
  end

  it 'restaurant not found' do
    get(
      "/restaurants/9324282/menus/1"
    )

    expect(response.status).to eql 404
    expect(response.body).to eql(
      {
        error: "Couldn't find Restaurant with 'id'=9324282"
      }.to_json
    )
  end

  it 'menu not found' do
    get(
      "/restaurants/#{menu.restaurant.id}/menus/8302103"
    )

    expect(response.status).to eql 404
    expect(response.body).to eql(
      {
        error: "Couldn't find Menu with 'id'=8302103 [WHERE \"menus\".\"restaurant_id\" = $1]"
      }.to_json
    )
  end

  it 'list menus' do
    get(
      "/restaurants/#{menu.restaurant.id}/menus"
    )

    expect(response.status).to eql 200
    expect(response.body).to eql(
      {
        menus: [
          {
            id: menu.id,
            name: menu.name
          }
        ]
      }.to_json
    )
  end
end
