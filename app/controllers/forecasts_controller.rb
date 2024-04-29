class ForecastsController < ApplicationController
  def new; end

  def show
    flash[:notice] = 'Refreshed Cache' if force_cache?

    render locals: { weather: weather, zip: zip, cached: @cached }
  rescue ArgumentError => e
    flash[:error] = e.message
    redirect_to new_forecast_path
  end

  def create
    if params[:zip].present?
      redirect_to forecast_path(params[:zip])
    else
      flash[:error] = t('create.blank_zip_code_error')
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

  def force_cache?
    params[:force_cache] == 'true'
  end

  def weather
    if Rails.cache.exist?(zip) && !force_cache?
      @cached = false
      Rails.cache.read(zip).with_indifferent_access
    else
      geocode_response = ::OpenWeather::Geocode.perform(zip)
      geocode_json = JSON.parse(geocode_response.body)

      current_response = ::OpenWeather::Current.perform(geocode_json['lat'], geocode_json['lon'])
      current_json = JSON.parse(current_response.body)

      daily_response = ::OpenWeather::DailyAggregation.perform(geocode_json['lat'], geocode_json['lon'])

      weather_data = JSON.parse(daily_response.body).tap do |data|
        data['current'] = current_json['current']
      end

      Rails.cache.write(zip, weather_data, expires_in: 30.minutes)
      @cached = true
      weather_data.with_indifferent_access
    end
  rescue ArgumentError => e
    raise ArgumentError.new(t('weather.blank_zip_code_error')) if e.message == 'key cannot be blank'

    raise e
  end
end
