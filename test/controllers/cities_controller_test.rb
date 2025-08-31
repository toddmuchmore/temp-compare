require "test_helper"

class CitiesControllerTest < ActionController::TestCase
  setup do
    # Clear session before each test
    session[:cities] = []
  end

  test "should get index with no cities" do
    get :index
    assert_response :success
    assert_equal [], assigns(:cities)
    assert_equal [], assigns(:weather_data)
  end

  test "should get index with cities" do
    session[:cities] = [ "London", "New York" ]

    # Mock the WeatherService.get_weather method
    def WeatherService.get_weather(city)
      case city
      when "London"
        { city: "London", temp_c: 15.0, temp_f: 59.0, temp_min_c: 12.0, temp_min_f: 53.6, temp_max_c: 18.0, temp_max_f: 64.4, condition: "Cloudy", icon: "04d" }
      when "New York"
        { city: "New York", temp_c: 20.0, temp_f: 68.0, temp_min_c: 17.0, temp_min_f: 62.6, temp_max_c: 23.0, temp_max_f: 73.4, condition: "Sunny", icon: "01d" }
      else
        nil
      end
    end

    get :index
    assert_response :success
    assert_equal [ "London", "New York" ], assigns(:cities)
    expected_weather = [
      { city: "London", temp_c: 15.0, temp_f: 59.0, temp_min_c: 12.0, temp_min_f: 53.6, temp_max_c: 18.0, temp_max_f: 64.4, condition: "Cloudy", icon: "04d" },
      { city: "New York", temp_c: 20.0, temp_f: 68.0, temp_min_c: 17.0, temp_min_f: 62.6, temp_max_c: 23.0, temp_max_f: 73.4, condition: "Sunny", icon: "01d" }
    ]
    assert_equal expected_weather, assigns(:weather_data)
  end

  test "should create city with valid name" do
    assert_difference -> { session[:cities].size }, 1 do
      post :create, params: { city_name: "Tokyo" }
    end
    assert_redirected_to root_path
    assert_includes session[:cities], "Tokyo"
  end

  test "should not create city with empty name" do
    assert_no_difference -> { session[:cities].size } do
      post :create, params: { city_name: "" }
    end
    assert_redirected_to root_path
  end

  test "should not create duplicate city" do
    session[:cities] = [ "London" ]
    assert_no_difference -> { session[:cities].size } do
      post :create, params: { city_name: "London" }
    end
    assert_redirected_to root_path
    assert_equal [ "London" ], session[:cities]
  end

  test "should destroy existing city" do
    session[:cities] = [ "London", "Paris" ]
    assert_difference -> { session[:cities].size }, -1 do
      delete :destroy, params: { city_name: "London" }
    end
    assert_redirected_to root_path
    assert_not_includes session[:cities], "London"
    assert_includes session[:cities], "Paris"
  end

  test "should handle destroy non-existing city" do
    session[:cities] = [ "London" ]
    assert_no_difference -> { session[:cities].size } do
      delete :destroy, params: { city_name: "NonExistent" }
    end
    assert_redirected_to root_path
    assert_equal [ "London" ], session[:cities]
  end

  test "should handle unavailable weather data" do
    session[:cities] = [ "UnknownCity" ]

    # Mock the WeatherService to return nil for unavailable data
    def WeatherService.get_weather(city)
      nil
    end

    get :index
    assert_response :success
    assert_equal [ "UnknownCity" ], assigns(:cities)
    assert_equal [ nil ], assigns(:weather_data)
  end
end
