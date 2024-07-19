# WeatherApp
App talks to Open Weather API
It makes use of two end points; one for pulling the current data for the given city and another for pulling the hourly data for the same place.

Note: Original ask was to display forecast for the subsequent days; since a free version of that API is not available, I've used hourly forecast instead.

# App Flow

App has three screens.
Welcome screen 
  - Displays for five seconds and dimisses itself to show the Current Weather screen; Tapping on 'Get Started' should dimiss the screen immediately.
Current Weather screen 
  - Shows the current weather info (per the requirement specified) for any city provided in the text field at the top.
  - User needs to enter a city and press return on the keyboard to see the current weather info from the API
  - Tapping on the 'Hourly Forecast' should take the user to the screen where it shows the hourly forecast data for the same city.
Hourly Forecast screen
  - Displays the weather forecast info the next hours [up to 10 datasets] with 3 hours interval [this is by API design].
  - Tapping on 'Back' on the nav bar takes the user back to the 'Current Weather' screen.

# Functionality
- Initially displays a placeholder screen for current weather info and a blank screen for forecast info
- Displays current weather info like brief weather description, weather icon, temperature, feels like temperature, humidity, wind, city name.
- Displays forecast info like weather description, weather icon, temperature, feels like temperature
- Data is persisted in between app launches
- Animates the weather icon on the welcome screen
- Self dismisses welcome screen in 5 seconds, if not manually dismissed by the user using the button provided
- Makes use of built in SF icons for displaying weather info related icons, implements a custom purple button, color gradients, etc

