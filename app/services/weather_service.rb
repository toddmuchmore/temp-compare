class WeatherService
  include HTTParty
  base_uri "http://api.openweathermap.org/data/2.5"

  def initialize
    @api_key = Rails.application.credentials.openweathermap[:api_key]
  end

  def fetch_weather_by_city(city_name)
    return nil if @api_key.blank? || @api_key == "YOUR_API_KEY_HERE"

    response = self.class.get("/weather", {
      query: {
        q: city_name,
        appid: @api_key,
        units: "metric"  # This will give us Celsius directly
      }
    })

    if response.success?
      parse_weather_response(response.parsed_response)
    else
      nil
    end
  end

  private

  def parse_weather_response(data)
    {
      city: data["name"],
      temp_c: data["main"]["temp"].round(1),
      temp_f: celsius_to_fahrenheit(data["main"]["temp"]).round(1),
      condition: data["weather"].first["description"].titleize,
      icon: data["weather"].first["icon"]
    }
  end

  def celsius_to_fahrenheit(celsius)
    (celsius * 9.0 / 5.0) + 32.0
  end
end
