Rails.application.config.session_store :cookie_store,
  key: "_weather_compare_session",
  expire_after: 30.days
