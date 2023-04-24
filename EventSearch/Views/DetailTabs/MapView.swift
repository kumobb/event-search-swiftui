//
//  MapView.swift
//  EventSearch
//
//  Created by Desmond Wu on 4/22/23.
//

import SwiftUI
import MapKit

struct Marker: Identifiable {
    let lat: Double
    let lng: Double
    
    var id: String {
        String(lat) + String(lng)
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: lat, longitude: lng)
    }
}

struct MapView: View {
    let address: String?
    @State private var coordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    @State private var marker: Marker = Marker(lat: 0, lng: 0)
    
    
    var body: some View {
        if let address = address {
            Map(coordinateRegion: $coordinateRegion, annotationItems: [marker]) { marker in
                MapMarker(coordinate: marker.coordinate)
            }
            .task {
                let coords = await getCoordinates(address: address)
                coordinateRegion = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: coords[0], longitude: coords[1]),
                    span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
                marker = Marker(lat: coords[0], lng: coords[1])
            }
            .padding()
        } else {
            Text("Address not found")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(address: "1001 S. Stadium Dr, Inglewood, California")
    }
}
