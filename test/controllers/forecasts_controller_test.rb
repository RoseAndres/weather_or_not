require 'test_helper'

class ForecastsControllerTest < ActionDispatch::IntegrationTest
  test '200 with valid zip param' do
    VCR.use_cassette('forecast_90210') do
      get forecast_path('90210')

      assert_response :success
    end
  end

  test '200 with valid zip and :force_cache params' do
    VCR.use_cassette('forecast_90210') do
      get forecast_path('90210', force_cache: "true")

      assert_response :success
    end
  end

  test "flashes \"Refreshed Cache\" if the force_cache param is set" do
    VCR.use_cassette('forecast_90210') do
      get forecast_path('90210', force_cache: 'true')

      assert_equal 'Refreshed Cache', flash[:notice]
    end
  end

  test '302 without a zip code' do
    get forecast_path

    assert_response :redirect
    assert_redirected_to new_forecast_path
  end

  test 'flashes an error message without a zip code' do
    get forecast_path

    assert_equal I18n.t('controllers.forecasts.weather.blank_zip_code_error'), flash[:error]
  end

  test "shows an error message with an invalid zip code" do
    VCR.use_cassette('forecast_abcde') do
      get forecast_path('abcde')

      assert_response :redirect
      assert_equal I18n.t('controllers.forecasts.weather.location_not_found_error'), flash[:error]
    end
  end
end
