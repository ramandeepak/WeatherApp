# WeatherApp
App talks to Open Weather API
It makes use of two end points; one for pulling the current data for the given city and another for pulling the hourly data for the same place.

Note: 
  - Original ask was to display forecast for the subsequent days; since a free version of that API is not available, I've used hourly forecast instead.
  - Also, please note that unit tests are not included.
  - Built using Xcode 14.2 and iOS 16.2 SDK.
  - Please change the deployment target in Xcode before running, if you have to.

# App Flow / App Usage Instructions

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

# Potential Improvements
If it wasn't for the time constraint, the following improvements/additions could've been done to this project.
  - Make SwiftUI views more modular and reusable
  - Also, create reusable component for frequently used colors and gradients
  - Move all magic strings and constants to a common file
  - Ideally, coredata should be used for persisting data; or data could've be written to a file as well. For simplicty, UserDefaults is being used here.
  - AppID [API token] should be stored in an encrypted keychain in a real-world application.
  - Unit tests should be written for Viewmodels.
  - Create mock service that returns JSON stubs for response; this could be useful for unit testing as well as development work during server downtime
  - Introduced loose coupling using protocols wherever possible
  - Show a loading spinner during the API calls
  - Hide "Hourly Forecast" button or use a placeholder page when there is no forecast data to show initially
  - Currently code shows how various network and https errors can be handled. In a real app, the error should be sent back to the caller and handled gracefully.
    for instance, 500s can be handled by showing a reusable generic error message screen used across the app; time-outs can be handled by either implementing a auto-retry
    mechanism or even better, let the user retry manullay using pull-to-refresh UI mechanisms.
  - Use a service layer between viewmodel and network manager to create/build requests and handles responses; for simplicity, this app currently calls the network manager from the
    viewmodel itself. Ideally, viewmodel should prep-up the data returned from the service layer for presentation.
  - WeatherIconMapper can be improved to accommodate all weather conditions; include image assets for showing icons that matches all weather conditions.
  - Computed properties in the model can be moved to the appropriate viewmodels so that models remain clean of any logic.
