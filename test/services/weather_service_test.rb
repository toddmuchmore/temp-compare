require "test_helper"

class WeatherServiceTest < ActiveSupport::TestCase
  setup do
    @service = WeatherService.new
    @valid_api_key = "test_api_key"
    @test_city = "London"
  end

  test "celsius_to_fahrenheit converts correctly" do
    assert_equal 32.0, @service.send(:celsius_to_fahrenheit, 0)
    assert_equal 68.0, @service.send(:celsius_to_fahrenheit, 20)
    assert_equal 212.0, @service.send(:celsius_to_fahrenheit, 100)
  end

  test "parse_onecall_response formats data correctly" do
    api_response = {
      "current" => {
        "temp" => 25.0,
        "weather" => [ { "description" => "partly cloudy", "icon" => "02d" } ]
      },
      "daily" => [
        {
          "temp" => {
            "min" => 22.0,
            "max" => 28.0
          }
        }
      ]
    }

    result = @service.send(:parse_onecall_response, api_response, "New York")

    expected = {
      city: "New York",
      temp_c: 25.0,
      temp_f: 77.0,  # 25°C = 77°F
      temp_min_c: 22.0,
      temp_min_f: 71.6,  # 22°C = 71.6°F
      temp_max_c: 28.0,
      temp_max_f: 82.4,  # 28°C = 82.4°F
      condition: "Partly Cloudy",
      icon: "02d"
    }

    assert_equal expected, result
  end

  test "fetch_weather_by_city with missing API key returns nil" do
    # Test with a service that has no API key configured
    service = WeatherService.new
    # Temporarily set the API key to nil to simulate missing credentials
    service.instance_variable_set(:@api_key, nil)

    result = service.send(:fetch_weather_by_city, @test_city)
    assert_nil result
  end

  test "fetch_weather_by_city with placeholder API key returns nil" do
    # Test with placeholder API key
    service = WeatherService.new
    service.instance_variable_set(:@api_key, "YOUR_API_KEY_HERE")

    result = service.send(:fetch_weather_by_city, @test_city)
    assert_nil result
  end

  test "fetch_weather_by_city returns consistent results" do
    service = WeatherService.new
    service.instance_variable_set(:@api_key, @valid_api_key)

    # Mock the HTTParty get method to handle both geocoding and One Call API
    WeatherService.define_singleton_method(:get) do |url, options|
      if url.include?("geo/1.0/direct")
        # Mock geocoding response
        Struct.new(:success?, :parsed_response).new(
          true,
          [{ "lat" => 51.5074, "lon" => -0.1278 }]
        )
      else
        # Mock One Call API response
        Struct.new(:success?, :parsed_response).new(
          true,
          {
            "current" => {
              "temp" => 20.0,
              "weather" => [ { "description" => "clear sky", "icon" => "01d" } ]
            },
            "daily" => [
              {
                "temp" => {
                  "min" => 18.0,
                  "max" => 22.0
                }
              }
            ]
          }
        )
      end
    end

    # Multiple calls should return the same result (cached)
    result1 = service.send(:fetch_weather_by_city, @test_city)
    result2 = service.send(:fetch_weather_by_city, @test_city)
    result3 = service.send(:fetch_weather_by_city, @test_city)

    assert_equal @test_city, result1[:city]
    assert_equal result1, result2
    assert_equal result2, result3
  end

  test "get_coordinates returns lat/lon for valid city" do
    service = WeatherService.new
    service.instance_variable_set(:@api_key, @valid_api_key)

    # Mock geocoding API response
    mock_response = Struct.new(:success?, :parsed_response).new(
      true,
      [{ "lat" => 51.5074, "lon" => -0.1278 }]
    )

    WeatherService.define_singleton_method(:get) do |*args|
      mock_response
    end

    result = service.send(:get_coordinates, "London")
    assert_equal({ lat: 51.5074, lon: -0.1278 }, result)
  end

  test "get_coordinates returns nil for invalid city" do
    service = WeatherService.new
    service.instance_variable_set(:@api_key, @valid_api_key)

    # Mock empty geocoding response
    mock_response = Struct.new(:success?, :parsed_response).new(true, [])

    WeatherService.define_singleton_method(:get) do |*args|
      mock_response
    end

    result = service.send(:get_coordinates, "InvalidCity")
    assert_nil result
  end
end
