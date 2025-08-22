class CitiesController < ApplicationController
  def index
    @cities = session[:cities] || []
    @weather_data = @cities.map { |city_name| WeatherService.get_weather(city_name) }
  end

  def create
    city_name = params[:city_name]
    if city_name.present?
      session[:cities] ||= []
      session[:cities] << city_name unless session[:cities].include?(city_name)
    end
    redirect_to root_path
  end

  def destroy
    city_name = params[:city_name]
    if city_name.present? && session[:cities]
      session[:cities].delete(city_name)
    end
    redirect_to root_path
  end
end
