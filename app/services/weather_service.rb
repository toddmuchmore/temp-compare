class WeatherService
  include HTTParty

  def self.get_weather(city_name)
    new.fetch_weather_by_city(city_name)
  end

  def initialize
    @api_key = Rails.application.credentials.dig(:openweathermap, :api_key)
  end

  def fetch_weather_by_city(city_name)
    return nil if @api_key.blank? || @api_key == "YOUR_API_KEY_HERE"

    cache_key = "weather_#{city_name.downcase.strip}"
    Rails.cache.fetch(cache_key, expires_in: 15.minutes) do
      coordinates = get_coordinates(city_name)
      return nil unless coordinates

      response = self.class.get("https://api.openweathermap.org/data/3.0/onecall", {
        query: {
          lat: coordinates[:lat],
          lon: coordinates[:lon],
          appid: @api_key,
          units: "metric",
          exclude: "minutely,hourly,alerts"  # Only need current and daily data
        }
      })

      if response.success?
        parse_onecall_response(response.parsed_response, city_name)
      else
        nil
      end
    end
  end

  private

  def get_coordinates(city_name)
    response = self.class.get("http://api.openweathermap.org/geo/1.0/direct", {
      query: {
        q: city_name,
        limit: 1,
        appid: @api_key
      }
    })

    if response.success? && response.parsed_response.any?
      location = response.parsed_response.first
      {
        lat: location["lat"],
        lon: location["lon"]
      }
    else
      nil
    end
  end

  def parse_onecall_response(data, city_name)
    current = data["current"]
    daily = data["daily"].first

    {
      city: city_name,
      temp_c: current["temp"].round(1),
      temp_f: celsius_to_fahrenheit(current["temp"]).round(1),
      temp_min_c: daily["temp"]["min"].round(1),
      temp_min_f: celsius_to_fahrenheit(daily["temp"]["min"]).round(1),
      temp_max_c: daily["temp"]["max"].round(1),
      temp_max_f: celsius_to_fahrenheit(daily["temp"]["max"]).round(1),
      condition: current["weather"].first["description"].titleize,
      icon: current["weather"].first["icon"]
    }
  end

  def celsius_to_fahrenheit(celsius)
    (celsius * 9.0 / 5.0) + 32.0
  end
end
