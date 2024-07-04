//
//  TouristPlacesMapView.swift
//  CWK2Template
//

import Foundation
import SwiftUI
import CoreLocation
import MapKit

struct TouristPlacesMapView: View {
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    @State var locations: [Location] = []
    @State var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5216871, longitude: -0.1391574), latitudinalMeters: 600, longitudinalMeters: 600)

    var body: some View {
        NavigationView {
            VStack(spacing: 5) {
                if weatherMapViewModel.coordinates != nil {
                    VStack(spacing: 10) {
                        Map(coordinateRegion: $mapRegion, showsUserLocation: true, annotationItems: locations) { location in
                            MapMarker(coordinate: location.coordinates, tint: .red)
                        }
                    }
                    .ignoresSafeArea(.all)
                    .frame(height: 300)
                }

                Text("Tourist Attractions in \(weatherMapViewModel.city)")
                    .font(.title)
                    .padding(.top)

                List {
                    if (!locations.isEmpty) {
                        ForEach(locations) { location in
                            HStack {
                                if let image = location.imageNames.first {
                                    Image(image)
                                        .resizable()
                                        .cornerRadius(10)
                                        .frame(width: 120, height: 120)
                                } else {
                                    Text("No image")
                                }

                                VStack(alignment: .leading) {
                                    Text(location.name)
                                    Text(location.description)
                                        .foregroundColor(.gray)
                                        .padding(.top, 3)
                                    Link("Read More", destination: URL(string: location.link)!)
                                        .foregroundColor(.blue)
                                        .padding(.top, 3)
                                }
                                .padding(.leading)
                                .padding(.bottom)
                            }
                            .listRowSeparator(.hidden)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .padding(.horizontal, 30)
            }
        }
        .onAppear {
            locations = [] // resetting locations for new region
            mapRegion = weatherMapViewModel.region
            
            // process the loading of tourist places
            if let loadedLocations = weatherMapViewModel.loadLocationsFromJSONFile(cityName: weatherMapViewModel.city) {
                locations = loadedLocations
            }
        }
    }
}

// Preview disabled so it doesn't make API calls

//struct TouristPlacesMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        TouristPlacesMapView().environmentObject(WeatherMapViewModel())
//    }
//}
