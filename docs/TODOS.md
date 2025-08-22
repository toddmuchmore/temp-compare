# Temperature Compare – TODOs

## Phase 1 – MVP
- [x] Create new Rails 8 app with Tailwind: `rails new weather_compare --css=tailwind`
- [x] Add `httparty` (or `faraday`) gem for API calls
- [x] Configure OpenWeatherMap API key (Rails credentials)
- [x] Create `WeatherService` class:
  - [x] Fetch weather by city name
  - [x] Convert Kelvin → Celsius & Fahrenheit
  - [x] Return normalized hash `{ city, temp_c, temp_f, condition, icon }`
- [x] Add `CitiesController`
  - [x] `index` action → list selected cities
  - [x] `create` action → add city (store in `session[:cities]`)
  - [x] `destroy` action → remove city
- [x] Build `index.html.erb` view
  - [x] Form to add city
  - [x] Table/grid of cities with °C, °F, condition, icon
  - [x] "Remove" button per row
- [x] Style with Tailwind (responsive grid, clean minimal look)
- [x] Add comprehensive tests for CitiesController
- [x] Deploy to Render / Fly.io / Heroku

---

## Phase 2 – Enhancements
- [ ] Create `City` model & migration (store cities in DB instead of session)
- [ ] (Optional) Add `User` model + authentication
- [ ] Implement drag-and-drop city reordering (Stimulus + SortableJS)
- [ ] Add toggle for °C/°F emphasis, persist preference
- [ ] Auto-detect current location (via IP API or browser geolocation)
- [ ] Polish responsive layout for mobile

---

## Phase 3 – Stretch Goals
- [ ] Add 3-day forecast (OpenWeatherMap `/forecast` endpoint)
- [ ] Implement shareable URLs (`?cities=Toronto,London`)
- [ ] Build Slack/Discord bot (Rails job + API integration)
- [ ] Package as macOS/iOS widget (WebView or Electron wrapper)

