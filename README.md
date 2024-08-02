# SwiftUI Weather & POIs Application

## Overview

The SwiftUI Weather & Points of Interest (POIs) Application is a mobile app developed for iOS devices. The app provides real-time weather information and displays tourist places of interest on a map. It is designed to help tourists and users obtain accurate weather data and explore nearby attractions in a given location. The app utilizes SwiftUI, CoreLocation, MapKit, and the OpenWeatherMap API to deliver a seamless user experience.

## Features

The application provides the following key features:

### Weather Information

- **Current Weather:** Displays the current weather for a specified location, including temperature, weather conditions, date, and time.
- **Hourly Forecast:** Provides a scrollable view of hourly weather forecasts for the next 48 hours.
- **8-Day Forecast:** Displays a vertically scrollable view showing a daily weather summary for the next 8 days.

### Places of Interest

- **Map View:** Integrates a map displaying pins for tourist attractions in the specified location. Users can view detailed information about each place of interest.
- **Places List:** Shows a scrollable list of tourist places loaded from a local JSON file.

### Location Management

- **City Selection:** Allows users to select different cities, automatically updating weather information and points of interest for the selected location.

### Design and Usability

- **Apple Design Guidelines:** The app interface adheres to Apple's design principles for consistent and intuitive user interaction.
- **Data Formatting:** Ensures weather data and POI information are accurately formatted and displayed.

## Implementation Details

- **Frameworks Used:** The app is built using SwiftUI for the user interface, CoreLocation for location services, and MapKit for map rendering.
- **OpenWeatherMap API:** Retrieves real-time weather data using the OpenWeatherMap API. Users must register and obtain an API key for accessing the weather service.
- **Data Management:** Handles API calls and JSON data conversion to Swift using appropriate data flow management techniques.

## Usage

Upon launching the app, users will see the current weather for a default location (e.g., London). Users can navigate through the app to access different features, such as viewing weather forecasts, exploring places of interest on a map, and selecting new locations.

### App Navigation

- **Current Weather:** View current weather details for the selected location.
- **Forecast Tab:** Access detailed hourly and daily weather forecasts.
- **Places Tab:** Explore tourist attractions on the map and in a list format.
- **City Tab:** Change the location to update weather and POI data.

### Example

1. **Launch the App:** View current weather for London.
2. **Change Location:** Switch to a new city (e.g., Rome) using the City tab.
3. **Explore Weather:** View hourly and 8-day weather forecasts for Rome.
4. **Discover Places:** See tourist attractions in Rome on the map and in the list.
