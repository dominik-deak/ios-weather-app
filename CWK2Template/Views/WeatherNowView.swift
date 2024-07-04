//
//  WeatherNowView.swift
//  CWK2Template
//

import SwiftUI

struct WeatherNowView: View {
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    @State private var isLoading = false
    @State private var temporaryCity = ""

    var body: some View {
        ZStack {
            Image("sky")
                .opacity(0.5)

            VStack {
                HStack {
                    Text("Change Location")
                    TextField("Enter New Location", text: $temporaryCity)
                        .onSubmit {
                            isLoading = true
                            Task {
                                do {
                                    // write code to process user change of location
                                    try await weatherMapViewModel.getCoordinatesForCity(city: temporaryCity)
                                    if (!weatherMapViewModel.coordinatesError) {
                                        weatherMapViewModel.city = temporaryCity
                                        let newWeatherData = try await weatherMapViewModel.loadData(lat: weatherMapViewModel.coordinates?.latitude ?? 51.503300, lon: weatherMapViewModel.coordinates?.longitude ?? -0.079400)
                                        print("New weather data loaded: \(String(describing: newWeatherData.timezone))")
                                    }
                                } catch {
                                    print("Error loading new weather data: \(error)")
                                }
                                temporaryCity = "" // resetting temporaryCity to clear the text field
                                isLoading = false
                            }
                        }
                        .alert(isPresented: $weatherMapViewModel.coordinatesError) {
                            Alert(
                                title: Text("New Location Not Found"),
                                message: Text("The new location you've entered could not be found")
                            )
                        }
                }
                .bold()
                .font(.system(size: 20))
                .padding(10)
                .shadow(color: .blue, radius: 10)
                .cornerRadius(10)
                .fixedSize()
                .font(.custom("Arial", size: 26))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .cornerRadius(15)

                VStack {
                    HStack {
                        Text("Current Location: \(weatherMapViewModel.city)")
                    }
                    .bold()
                    .font(.system(size: 20))
                    .padding(10)
                    .shadow(color: .blue, radius: 10)
                    .cornerRadius(10)
                    .fixedSize()
                    .font(.custom("Arial", size: 26))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .cornerRadius(15)
                    
                    let timestamp = TimeInterval(weatherMapViewModel.weatherDataModel?.current.dt ?? 0)
                    let formattedDate = DateFormatterUtils.formattedDateTime(from: timestamp)
                    Text(formattedDate)
                        .padding()
                        .font(.title)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 1)

                    HStack {
                        // Weather Temperature Value
                        
                        // added ProgressView() and 'loading...' text while loading
                        if (isLoading) {
                            Grid {
                                GridRow {
                                    ProgressView()
                                    Text("Weather loading...")
                                        .font(.system(size: 22, weight: .medium))
                                }
                                .padding(.bottom, 10)
                                GridRow {
                                    ProgressView()
                                    Text("Temp: loading...")
                                        .font(.system(size: 22, weight: .medium))
                                }
                                .padding(.bottom, 10)
                                GridRow {
                                    ProgressView()
                                    Text("Humidity: loading...")
                                        .font(.system(size: 22, weight: .medium))
                                }
                                .padding(.bottom, 10)
                                GridRow {
                                    ProgressView()
                                    Text("Pressure: loading...")
                                        .font(.system(size: 22, weight: .medium))
                                }
                                .padding(.bottom, 10)
                                GridRow {
                                    ProgressView()
                                    Text("Windspeed: loading...")
                                        .font(.system(size: 22, weight: .medium))
                                }
                                .padding(.bottom, 10)
                            }
                        } else if let forecast = weatherMapViewModel.weatherDataModel {
                            Grid {
                                GridRow {
                                    if let currentWeather = forecast.current.weather.first {
                                        AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\((String)(currentWeather.icon))@2x.png")) { image in
                                            image.resizable()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(width: 45, height: 45)
                                        Text("\((String)(currentWeather.weatherDescription.rawValue.capitalized))")
                                            .font(.system(size: 22, weight: .medium))
                                    }
                                }
                                .padding(.bottom, 10)
                                GridRow {
                                    Image("temperature")
                                        .resizable()
                                        .frame(width: 45, height: 45)
                                    Text("Temp: \((Double)(forecast.current.temp), specifier: "%.0f") ºC")
                                        .font(.system(size: 22, weight: .medium))
                                }
                                .padding(.bottom, 10)
                                GridRow {
                                    Image("humidity")
                                        .resizable()
                                        .frame(width: 45, height: 45)
                                    Text("Humidity: \((Double)(forecast.current.humidity), specifier: "%.0f") %")
                                        .font(.system(size: 22, weight: .medium))
                                }
                                .padding(.bottom, 10)
                                GridRow {
                                    Image("pressure")
                                        .resizable()
                                        .frame(width: 45, height: 45)
                                    Text("Pressure: \((Double)(forecast.current.pressure), specifier: "%.0f") hPa")
                                        .font(.system(size: 22, weight: .medium))
                                }
                                .padding(.bottom, 10)
                                GridRow {
                                    Image("windSpeed")
                                        .resizable()
                                        .frame(width: 45, height: 45)
                                    Text("Windspeed: \((Double)(forecast.current.windSpeed), specifier: "%.0f") mph")
                                        .font(.system(size: 22, weight: .medium))
                                }
                            }
                        } else {
                            Grid {
                                Text("Weather error")
                                    .font(.system(size: 22, weight: .medium))
                                    .padding(.bottom, 10)
                                GridRow {
                                    Image("temperature")
                                        .resizable()
                                        .frame(width: 45, height: 45)
                                    Text("Temp: error")
                                        .font(.system(size: 22, weight: .medium))
                                }
                                .padding(.bottom, 10)
                                GridRow {
                                    Image("humidity")
                                        .resizable()
                                        .frame(width: 45, height: 45)
                                    Text("Humidity: error")
                                        .font(.system(size: 22, weight: .medium))
                                }
                                .padding(.bottom, 10)
                                GridRow {
                                    Image("pressure")
                                        .resizable()
                                        .frame(width: 45, height: 45)
                                    Text("Pressure: error")
                                        .font(.system(size: 22, weight: .medium))
                                }
                                .padding(.bottom, 10)
                                GridRow {
                                    Image("windSpeed")
                                        .resizable()
                                        .frame(width: 45, height: 45)
                                    Text("Windspeed: error")
                                        .font(.system(size: 22, weight: .medium))
                                }
                                .padding(.bottom, 10)
                            }
                        }
                    }
                    .padding(.top, 40)
                } //VS2
            } //VS1
            .frame(alignment: .top)
        } //ZS
        .padding(.bottom, 150)
    }
}

// Preview disabled so it doesn't make API calls

//struct WeatherNowView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherNowView().environmentObject(WeatherMapViewModel())
//    }
//}
