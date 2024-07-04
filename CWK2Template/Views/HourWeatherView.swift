//
//  HourWeatherView.swift
//  CWK2Template
//

import SwiftUI

struct HourWeatherView: View {
    var current: Current

    var body: some View {
        let formattedDate = DateFormatterUtils.formattedDateWithDay(from: TimeInterval(current.dt))
        VStack(alignment: .center, spacing: 5) {
            Text(formattedDate)
                .font(.body)
                .padding(.horizontal)
//                .background(Color.white)
                .foregroundColor(.black)
            
            if let currentWeather = current.weather.first {
                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\((String)(currentWeather.icon))@2x.png")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 40, height: 40)
                
                Text("\((Double)(current.temp), specifier: "%.0f")ºC")
                    .font(.system(size: 18, weight: .regular))
                
                Text("\((String)(currentWeather.weatherDescription.rawValue.capitalized))")
                    .font(.system(size: 18, weight: .regular))
            }
        }
        .padding()
        .background(Color(red: 0, green: 0.7, blue: 0.8))
        .cornerRadius(10)
    }
}

// Preview disabled so it doesn't make API calls

//struct HourWeatherView_Previews: PreviewProvider {
//    static var previews: some View {
//        HourWeatherView(current: Current(dt: 0, sunrise: 0, sunset: 0, temp: 0, feelsLike: 0, pressure: 0, humidity: 0, dewPoint: 0, uvi: 0, clouds: 0, visibility: 0, windSpeed: 0, windDeg: 0, weather: [Weather], windGust: 0, pop: 0, rain: Rain?))
//    }
//}
