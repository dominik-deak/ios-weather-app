//
//  NavBar.swift
//  CWK2Template
//

import SwiftUI

struct NavBar: View {
    var body: some View {
        TabView {
            Group {
                WeatherNowView()
                    .tabItem {
                        Label("City", systemImage: "magnifyingglass")
                    }
                WeatherForecastView()
                    .tabItem {
                        Label("Forecast", systemImage: "calendar")
                    }
                TouristPlacesMapView()
                    .tabItem {
                        Label("Place Map", systemImage: "map")
                    }
            }
            // toolbarBackground method source:
            // https://sarunw.com/posts/swiftui-tabview-color/
            .toolbarBackground(.white, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
        }
    }
}

// Preview disabled so it doesn't make API calls

//struct NavBar_Previews: PreviewProvider {
//    static var previews: some View {
//        NavBar().environmentObject(WeatherMapViewModel())
//    }
//}
