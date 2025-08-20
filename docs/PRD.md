# Product Requirements Document (PRD)

**Product Name:** Weather Compare  
**Goal:** Enable users to compare weather across multiple cities in both Celsius and Fahrenheit, side-by-side.

---

## 1. Problem Statement
Users in different regions talk about weather using different units (°C vs °F). This causes confusion in daily communication. We need a simple tool that displays multiple locations with temperatures in both units for quick comparison.

---

## 2. Objectives
- Provide a minimal, fast-loading web app.
- Support multiple cities at once.
- Show current temperature in both °C and °F.
- Display basic conditions (sunny, cloudy, rain) with an icon.
- Be easily sharable via link (no install friction).

---

## 3. Key Features
### Core MVP
- Search & add cities by name.
- Display a list/grid of cities with:
  - City name
  - Temperature in °C and °F
  - Weather condition text
  - Weather icon
- Remove city from list.
- Persist cities in session (later DB).

### Nice-to-Have (Phase 2)
- Reorder cities via drag-and-drop.
- Toggle default emphasis (°C left vs °F left).
- Auto-detect user location.
- Mobile-friendly responsive design.

### Stretch Goals (Future)
- Daily high/low temperatures.
- Forecast (next 3 days).
- Shareable URL encoding selected cities.
- Slack/Discord integration.

---

## 4. Non-Goals
- No radar maps or advanced visualization.
- No historical weather data.
- Not a replacement for full-featured weather apps.

---

## 5. User Stories
- *As a user, I want to add my coworkers’ cities so I can see their weather side-by-side with mine.*
- *As a user, I want to view temperatures in both °C and °F so I can translate quickly.*
- *As a user, I want the app to remember my last cities so I don’t re-enter them every time.*
- *As a user, I want the app to be fast and lightweight so I can check it on desktop or mobile easily.*

---

## 6. Requirements
### Functional
- City search powered by API.
- Fetch current weather for each city.
- Store cities in session or DB.
- Display results in a grid.

### Technical
- Framework: Ruby on Rails 8.
- Styling: Tailwind CSS.
- Weather API: OpenWeatherMap.
- Persistence: Session (MVP), DB (later).
- Hosting: Render / Fly.io / Heroku.

---

## 7. Design
- Minimal, table-like layout.
- Responsive grid.
- Icons for conditions.
- Option for light/dark mode.

---

## 8. KPIs / Success Metrics
- Load time < 1s on broadband.
- Support >5 cities smoothly.
- Correct unit conversions.

