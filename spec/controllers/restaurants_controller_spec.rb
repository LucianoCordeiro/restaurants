require 'rails_helper'

RSpec.describe RestaurantsController, type: :request do
  let!(:restaurant) { FactoryBot.create(:restaurant) }
  let!(:menu) { FactoryBot.create(:menu, restaurant: restaurant) }

  it 'restaurant found' do
    get(
      "/restaurants/#{restaurant.id}"
    )

    expect(response.status).to eql 200
    expect(response.body).to eql(
      {
        restaurant: {
          id: restaurant.id,
          name: restaurant.name,
          menus: [
            {
              name: menu.name
            }
          ]
        }
      }.to_json
    )
  end

  it 'restaurant not found' do
    get(
      "/restaurants/930292"
    )

    expect(response.status).to eql 404
    expect(response.body).to eql(
      {
        error: "Couldn't find Restaurant with 'id'=930292"
      }.to_json
    )
  end

  it 'list restaurants' do
    get(
      "/restaurants"
    )

    expect(response.status).to eql 200
    expect(response.body).to eql(
      {
        restaurants: [
          {
            id: restaurant.id,
            name: restaurant.name
          }
        ]
      }.to_json
    )
  end
end
