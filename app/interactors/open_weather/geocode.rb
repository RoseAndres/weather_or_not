module OpenWeather
  class Geocode < ApplicationInteractor
    BASE_URL = 'http://api.openweathermap.org/geo/1.0/zip'

    def initialize(zip_code)
      if zip_code.nil? || zip_code.empty?
        raise ArgumentError, 'Must have a zip code'
      end

      @zip_code = zip_code
    end

    # * `location` is a string in the format of 'zip, country'
    def perform
      response = HTTP.get(BASE_URL, params: params)

      if response.status.success? && response.body.present?
        response
      else
        raise ArgumentError, 'Error fetching location'
      end
    end

    private

    def api_key
      Rails.application.credentials.dig(:open_weather, :api_key)
    end

    # ? hard-coding country to US, since we'll only be cacheing by zip code, not zip + country.
    # ? this is a simple way to prevent potential zip code collisions with other countries.
    def location_string
      "#{@zip_code},US"
    end

    def params
      {
        zip: location_string,
        appid: api_key,
        limit: 1
      }
    end
  end
end
