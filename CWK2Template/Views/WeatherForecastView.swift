//
//  WeatherForcastView.swift
//  CWK2Template
//

import SwiftUI

struct WeatherForecastView: View {
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue.opacity(0.3)
                    .frame(height: 500)
                    .padding(.top, -500)
                    .padding(.horizontal)

                ScrollView {
                    VStack(spacing: 16) {
                        if let hourlyData = weatherMapViewModel.weatherDataModel?.hourly {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(hourlyData) { hour in
                                        HourWeatherView(current: hour)
                                    }
                                }
                            }
                            .padding(.bottom, 10)
                        }

                        Divider()
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                        
                        VStack {
                            List {
                                ForEach(weatherMapViewModel.weatherDataModel?.daily ?? []) { day in
                                    DailyWeatherView(day: day)
                                }
                                .listRowSeparator(.hidden)
                            }
                            .listStyle(PlainListStyle())
                            .frame(height: 600)
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                            ToolbarItem(placement: .principal) {
                                HStack {
                                    Image(systemName: "sun.min.fill")
                                    VStack{
                                        Text("Weather Forecast for \(weatherMapViewModel.city)").font(.title3)
                                            .fontWeight(.bold)
                                    }
                                }
                            }
                        }
            }
        }
    }
}

// Preview disabled so it doesn't make API calls

//struct WeatherForcastView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherForecastView().environmentObject(WeatherMapViewModel())
//    }
//}
