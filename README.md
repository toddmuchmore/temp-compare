# Temperature Compare

A minimal web app to compare current weather across multiple cities in both Celsius and Fahrenheit, powered by OpenWeatherMap API.

## Features
- Search and add cities by name.
- Display temperatures in °C and °F side-by-side.
- Show weather conditions with icons.
- Persist selected cities in session.
- Responsive design with Tailwind CSS.

## Prerequisites
- Ruby 3.2+ (check `.ruby-version`)
- Rails 8
- OpenWeatherMap API key

## Setup
1. Clone the repository.
2. Install dependencies: `bundle install`
3. Set up credentials: `rails credentials:edit` and add your OpenWeatherMap API key.
4. Run migrations: `rails db:migrate`
5. Start the server: `rails server`

## Usage
- Visit the homepage to add cities and view weather comparisons.
- Add/remove cities via the form and buttons.

## Testing
- Run tests: `rails test`

## Deployment
- Deploy to Render, Fly.io, or Heroku using provided configs.

