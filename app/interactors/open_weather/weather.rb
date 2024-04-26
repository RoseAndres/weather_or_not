module OpenWeather
  class Weather < ApplicationInteractor
    BASE_URL = 'https://api.openweathermap.org/data/3.0/onecall'

    def initialize(lat, lon)
      raise ArgumentError, 'Must have latitude and longitude' if lat.nil? || lon.nil?
      raise ArgumentError, 'Invalid latitude' unless lat.is_a?(Numeric)
      raise ArgumentError, 'Invalid longitude' unless lon.is_a?(Numeric)

      @lat = lat
      @lon = lon
    end

    def perform
      HTTP.get(BASE_URL, params: params)
    end

    private

    def api_key
      Rails.application.credentials.dig(:open_weather, :api_key)
    end

    def params
      {
        lat: @lat,
        lon: @lon,
        appid: api_key
      }
    end
  end
end
