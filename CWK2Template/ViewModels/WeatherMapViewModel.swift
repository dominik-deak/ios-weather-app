//
//  WeatherMapViewModel.swift
//  CWK2Template
//

import Foundation
import SwiftUI
import CoreLocation
import MapKit

class WeatherMapViewModel: ObservableObject {
    // MARK:   published variables
    @Published var weatherDataModel: WeatherDataModel?
    @Published var city = "London"
    @Published var coordinates: CLLocationCoordinate2D?
    @Published var region: MKCoordinateRegion = MKCoordinateRegion()
    @Published var coordinatesError = false

    init() {
        // MARK:  create Task to load London weather data when the app first launches
        Task {
            do {
                try await getCoordinatesForCity(city: city)
                let weatherData = try await loadData(lat: coordinates?.latitude ?? 51.503300, lon: coordinates?.longitude ?? -0.079400)
                print("Weather data loaded: \(String(describing: weatherData.timezone))")
            } catch {
//                 Handle errors if necessary
                print("Error loading weather data: \(error)")
            }
        }
    }

    // MARK:  complete the code to get user coordinates for user entered place
    // and specify the map region

    // Added city parameter, so WeatherNowView checks if it's a valid city
    // before updating the viewModel's published variable
    func getCoordinatesForCity(city: String) async throws {
        let geocoder = CLGeocoder()
        if let placemarks = try? await geocoder.geocodeAddressString(city),
           let location = placemarks.first?.location?.coordinate {
            DispatchQueue.main.async {
                self.coordinates = location

                // Increased latitudeDelta and longitudeDelta values
                // to be able to see all map annotations
                self.region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.06, longitudeDelta: 0.06))
            }
        } else {
            // Handle error here if geocoding fails
            print("Error: Unable to find the coordinates for the city.")
            DispatchQueue.main.async {
                self.coordinatesError = true
            }
        }
    }

    func loadData(lat: Double, lon: Double) async throws -> WeatherDataModel {
        // MARK:  add your appid in the url below:
        if let url = URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&units=metric&appid=ba98e15ef80e580e5db2ad810f308a07") {
            let session = URLSession(configuration: .default)

            do {
                let (data, _) = try await session.data(from: url)
                let weatherDataModel = try JSONDecoder().decode(WeatherDataModel.self, from: data)

                DispatchQueue.main.async {
                    self.weatherDataModel = weatherDataModel
//                    print("weatherDataModel loaded")
                }

                // MARK:  The code below is to help you see number of records and different time stamps that has been retrieved as part of api response.
//                print("MINUTELY")
//                if let count = weatherDataModel.minutely?.count {
//                    if let firstTimestamp = weatherDataModel.minutely?[0].dt {
//                        let firstDate = Date(timeIntervalSince1970: TimeInterval(firstTimestamp))
//                        let formattedFirstDate = DateFormatterUtils.shared.string(from: firstDate)
//                        print("First Timestamp: \(formattedFirstDate)")
//                    }
//
//                    if let lastTimestamp = weatherDataModel.minutely?[count - 1].dt {
//                        let lastDate = Date(timeIntervalSince1970: TimeInterval(lastTimestamp))
//                        let formattedLastDate = DateFormatterUtils.shared.string(from: lastDate)
//                        print("Last Timestamp: \(formattedLastDate)")
//                    }
//                }

//                print("Hourly start")
//                let hourlyCount = weatherDataModel.hourly.count
//                print(hourlyCount)
                // removed duplicate if block and moved contents into first if block
//                if hourlyCount > 0 {
//                    let firstTimestamp = weatherDataModel.hourly[0].dt
//                    let firstDate = Date(timeIntervalSince1970: TimeInterval(firstTimestamp))
//                    let formattedFirstDate = DateFormatterUtils.shared.string(from: firstDate)
//                    print("First Hourly Timestamp: \(formattedFirstDate)")
//                    print("Temp in first hour: \(weatherDataModel.hourly[0].temp)")
//                    
//                    let lastTimestamp = weatherDataModel.hourly[hourlyCount - 1].dt
//                    let lastDate = Date(timeIntervalSince1970: TimeInterval(lastTimestamp))
//                    let formattedLastDate = DateFormatterUtils.shared.string(from: lastDate)
//                    print("Last Hourly Timestamp: \(formattedLastDate)")
//                    print("Temp in last hour: \(weatherDataModel.hourly[hourlyCount - 1].temp)")
//                }
//                print("Hourly Complete")

//                print("Daily start")
//                let dailyCount = weatherDataModel.daily.count
//                print(dailyCount)
                // removed duplicate if block and moved contents into first if block
//                if dailyCount > 0 {
//                    let firstTimestamp = weatherDataModel.daily[0].dt
//                    let firstDate = Date(timeIntervalSince1970: TimeInterval(firstTimestamp))
//                    let formattedFirstDate = DateFormatterUtils.shared.string(from: firstDate)
//                    print("First daily Timestamp: \(formattedFirstDate)")
//                    print("Temp for first day: \(weatherDataModel.daily[0].temp)")
//                    // renamed incorrectly named variables from 'first' to 'last'
//                    let lastTimestamp = weatherDataModel.daily[dailyCount-1].dt
//                    let lastDate = Date(timeIntervalSince1970: TimeInterval(lastTimestamp))
//                    let formattedLastDate = DateFormatterUtils.shared.string(from: lastDate)
//                    print("Last daily Timestamp: \(formattedLastDate)")
//                    print("Temp for last day: \(weatherDataModel.daily[dailyCount-1].temp)")
//                }
//                print("daily complete")
                
                return weatherDataModel
            } catch {
                if let decodingError = error as? DecodingError {
                    print("Decoding error: \(decodingError)")
                } else {
                    //  other errors
                    print("Error: \(error)")
                }
                throw error // Re-throw the error to the caller
            }
        } else {
            throw NetworkError.invalidURL
        }
    }

    enum NetworkError: Error {
        case invalidURL
    }

    // function modified so it only returns the searched locations instead of all of them
    func loadLocationsFromJSONFile(cityName: String) -> [Location]? {
        if let fileURL = Bundle.main.url(forResource: "places", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                let allLocations = try decoder.decode([Location].self, from: data)

                let filteredLocations = allLocations.filter { $0.cityName == cityName }
                return filteredLocations.isEmpty ? nil : filteredLocations
            } catch {
                print("Error decoding JSON: \(error)")
            }
        } else {
            print("File not found")
        }
        return nil
    }
}
