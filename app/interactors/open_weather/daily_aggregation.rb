module OpenWeather
  class DailyAggregation < ApplicationInteractor
    BASE_URL = 'https://api.openweathermap.org/data/3.0/onecall/day_summary'

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
        date: Date.current.to_s,
        units: 'imperial',
        appid: api_key
      }
    end
  end
end
