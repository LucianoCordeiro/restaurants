require 'rails_helper'

RSpec.describe ImportController, type: :request do
  subject do
    post(
      "/import", params: { file: Rack::Test::UploadedFile.new('spec/fixtures/files/restaurant_data.json', 'application/json', true) }
    )
  end

  let(:restaurant_data) { JSON.parse(file_fixture("restaurant_data.json").read).deep_symbolize_keys }

  it 'import restaurants' do
    allow(RestaurantDataProcessor).to receive(:perform).with(restaurant_data).and_return(
      [
        {
          menu_item: "Burger",
          menu: "lunch",
          restaurant: "Poppo's Cafe",
          success: true,
          errors: []
        }
      ]
    )

    subject

    expect(response.status).to eql 200
    expect(response.body).to eql(
      {
        result: [
          {
            menu_item: "Burger",
            menu: "lunch",
            restaurant: "Poppo's Cafe",
            success: true,
            errors: []
          }
        ]
      }.to_json
    )
  end

  it 'bad request' do
    allow(RestaurantDataProcessor).to receive(:perform).with(restaurant_data).and_raise("Something went wrong")

    subject

    expect(response.status).to eql 400

    expect(response.body).to eql(
      {
        error: "Something went wrong"
      }.to_json
    )
  end
end
