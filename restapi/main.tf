data "restapi2" "weather" {
  uri          = "https://api.weather.gov/gridpoints/PHI/63,115/forecast"
  method       = "GET"
}
