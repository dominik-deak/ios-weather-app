//
//  DailyWeatherView.swift
//  CWK2Template
//

import SwiftUI

struct DailyWeatherView: View {
    var day: Daily
    var body: some View {
        HStack {
            if let dailyWeather = day.weather.first {
                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\((String)(dailyWeather.icon))@2x.png")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 60, height: 60)
                
                Spacer()

                VStack {
                    Text("\((String)(dailyWeather.weatherDescription.rawValue.capitalized))")
                        .font(.system(size: 18, weight: .regular))
                    
                    let formattedDate = DateFormatterUtils.formattedDateWithWeekdayAndDay(from: TimeInterval(day.dt))
                    Text(formattedDate)
                }
            }
            
            Spacer()

            // The coursework brief didn't specify which 2 of the 6 temperature values should be displayed
            // so I chose max and min for the day
            Text("\(day.temp.max, specifier: "%.0f")ºC / \(day.temp.min, specifier: "%.0f")ºC")
                        .font(.system(size: 18, weight: .regular))
        }
        .background(
            Image(.background)
                .resizable()
                .opacity(0.15)
        )
        .padding(.vertical, -10)
    }
}

// Preview disabled so it doesn't make API calls

//struct DailyWeatherView_Previews: PreviewProvider {
//    static var day = WeatherMapViewModel().weatherDataModel?.daily.first
//    static var previews: some View {
//        DailyWeatherView(day: day ?? Daily(dt: 0, sunrise: 0, sunset: 0, moonrise: 0, moonset: 0, moonPhase: 0.0, temp: Temp(day: 0.0, min: 0.0, max: 0.0, night: 0.0, eve: 0.0, morn: 0.0), feelsLike: FeelsLike(day: 0.0, night: 0.0, eve: 0.0, morn: 0.0), pressure: 0, humidity: 0, dewPoint: 0.0, windSpeed: 0.0, windDeg: 0, windGust: 0.0, weather: [Weather(id: 0, main: .clear, weatherDescription: .Haze, icon: "")], clouds: 0, pop: 0.0, rain: 0.0, uvi: 0.0))
//    }
//}
