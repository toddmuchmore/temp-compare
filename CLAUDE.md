# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Temperature Compare is a Rails 8 web application that allows users to compare current weather across multiple cities in both Celsius and Fahrenheit. It uses the OpenWeatherMap API for weather data and features a clean, responsive UI built with Tailwind CSS.

## Development Commands

### Setup
```bash
bundle install                    # Install Ruby dependencies
rails credentials:edit           # Configure OpenWeatherMap API key
rails db:migrate                 # Run database migrations
```

### Running the Application
```bash
rails server                     # Start development server (port 3000)
```

### Testing
```bash
rails test                       # Run all tests
rails test test/controllers/     # Run controller tests only
rails test test/services/        # Run service tests only
```

### Code Quality
```bash
bin/rubocop                      # Run Ruby linting with omakase config
bin/brakeman                     # Security vulnerability scanning
```

## Architecture

### Core Components

**CitiesController** (`app/controllers/cities_controller.rb`)
- Manages city list stored in session
- Coordinates with WeatherService to fetch weather data
- Actions: index (display), create (add city), destroy (remove city)

**WeatherService** (`app/services/weather_service.rb`)
- Handles OpenWeatherMap API integration using HTTParty
- Implements 15-minute caching with Rails.cache
- Converts temperatures between Celsius and Fahrenheit
- Safely handles missing API keys and API failures

**Frontend**
- Uses Tailwind CSS for styling with responsive design
- Stimulus controller for real-time temperature conversion (`temperature_converter_controller.js`)
- Hotwire/Turbo for SPA-like navigation without JavaScript frameworks

### Data Storage
- Session-based city persistence (no database models for cities)
- Weather data cached for 15 minutes to reduce API calls
- Uses SQLite for Rails cache storage via solid_cache gem

### API Integration
- OpenWeatherMap API key stored in Rails credentials: `rails.application.credentials.dig(:openweathermap, :api_key)`
- Metric units requested from API, Fahrenheit calculated in WeatherService
- Error handling for API failures and missing credentials

### Testing Strategy
- Controller tests mock WeatherService responses to avoid API calls
- Service tests should use VCR or similar for API integration testing
- No system tests currently implemented but capybara/selenium configured

## Key Dependencies

- **Rails 8** with Propshaft asset pipeline
- **HTTParty** for API requests
- **Tailwind CSS** for styling
- **Stimulus** for minimal JavaScript interactions
- **solid_cache/solid_queue** for background jobs and caching
- **rubocop-rails-omakase** for code style
- **brakeman** for security scanning

## Environment Requirements

- Ruby 3.4.2 (see `.ruby-version`)
- OpenWeatherMap API key required for functionality
- All weather features gracefully degrade when API is unavailable