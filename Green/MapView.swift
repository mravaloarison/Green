//
//  MapView.swift
//  Green
//
//  Created by Mami Ravaloarison on 11/9/24.
//

import SwiftUI
import MapKit

// TODO: Update on search
extension CLLocationCoordinate2D {
    static let defaultPosition = CLLocationCoordinate2D(latitude: 40.75217554712658, longitude: -73.98177565965064)
    static let defaultPosition2 = CLLocationCoordinate2D(latitude: 40.7827252711707, longitude: -73.96556194559376)
}

struct MapView: View {
    @State private var position: MapCameraPosition = .camera(
        MapCamera(centerCoordinate: .defaultPosition, distance: 980, heading: 0, pitch: 40)
    )
    
    @State private var fromPositionCoordinate: CLLocationCoordinate2D = .defaultPosition
    
    @State private var toPositionCoordinate: CLLocationCoordinate2D = .defaultPosition2

    var body: some View {
        Map() {
            Marker("From", systemImage: "car.fill", coordinate: fromPositionCoordinate)
                .tint(.yellow)
            
            Marker("To", systemImage: "location.fill.viewfinder", coordinate: toPositionCoordinate)
                .tint(.blue)
        }
        .mapStyle(.standard(elevation: .realistic))
    }
}

#Preview {
    MapView()
}

