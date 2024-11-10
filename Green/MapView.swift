//
//  MapView.swift
//  Green
//
//  Created by Mami Ravaloarison on 11/9/24.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

extension CLLocationCoordinate2D {
    static let defaultPosition = CLLocationCoordinate2D(latitude: 40.75217554712658, longitude: -73.98177565965064)
    static let defaultPosition2 = CLLocationCoordinate2D(latitude: 40.7827252711707, longitude: -73.96556194559376)
}

struct MapView: View {
    @EnvironmentObject var locationManager: LocationManager

    @State private var position: MapCameraPosition = .camera(
        MapCamera(centerCoordinate: .defaultPosition, distance: 980, heading: 0, pitch: 40)
    )
    
    @State private var isToLocationSet: Bool = false

    var body: some View {
        Map(position: $position) {
            Marker("From", systemImage: "car.fill", coordinate: locationManager.fromPositionCoordinate)
                .tint(.yellow)

            if isToLocationSet {
                Marker("To", systemImage: "location.fill.viewfinder", coordinate: locationManager.toPositionCoordinate)
                    .tint(.indigo)
            }
        }
        .mapStyle(.standard(elevation: .realistic))
        .onAppear {
            position = .camera(
                MapCamera(centerCoordinate: locationManager.fromPositionCoordinate, distance: 980, heading: 0, pitch: 40)
            )
        }
        .onChange(of: locationManager.fromPositionCoordinate) {
            position = .camera(
                MapCamera(centerCoordinate: locationManager.fromPositionCoordinate, distance: 980, heading: 0, pitch: 40)
            )
        }
        .onChange(of: locationManager.toPositionCoordinate) {
            if locationManager.toPositionCoordinate != .defaultPosition2 {
                isToLocationSet = true
                position = .automatic
            }
        }
    }
}

#Preview {
    MapView()
        .environmentObject(LocationManager())
}
