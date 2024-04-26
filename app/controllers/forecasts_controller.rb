class ForecastsController < ApplicationController
  def new; end

  def show
    render locals: { weather: weather, zip: zip }
  rescue ArgumentError => e
    flash[:error] = e.message
    redirect_to new_forecast_path
  end

  def create
    if params[:zip].present?
      redirect_to forecast_path(params[:zip])
    else
      flash[:error] = "Location can't be blank"
      redirect_to new_forecast_path
    end
  end

  private

  def zip
    @zip ||= if action_name == 'show'
               params[:id] # ? Rails 6.1+ uses `params[:id]` for the `show` action
             elsif action_name == 'create'
               params.permit[:zip]
             end
  end

  def weather
    if Rails.cache.exist?(zip)
      Rails.cache.read(zip)
    else
      geocode_response = ::OpenWeather::Geocode.perform(zip)
      geocode_json = JSON.parse(geocode_response.body)

      weather_response = ::OpenWeather::Weather.perform(geocode_json['lat'], geocode_json['lon'])
      weather_json = JSON.parse(weather_response.body)

      Rails.cache.write(zip, weather_json, expires_in: 30.minutes)
      weather_json
    end
  end
end
