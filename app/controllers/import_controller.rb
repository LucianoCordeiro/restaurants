class ImportController < ApplicationController
  def import
    restaurants = JSON.parse(File.read(params[:file].tempfile)).deep_symbolize_keys

    result = RestaurantDataProcessor.perform(restaurants)

    render json: { result: result }
  rescue => e
    render json: { error: e.message }, status: 400
  end
end
