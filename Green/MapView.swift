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
    
    @State private var globalDefaultRoute: MKRoute?
    @State private var globalLessCarbonEmissionRoute: MKRoute?
    
    @State private var isDefaultRouteActive: Bool = true

    var body: some View {
        Map(position: $position) {
            Marker(locationManager.fromPositionName, systemImage: "car.fill", coordinate: locationManager.fromPositionCoordinate)
                .tint(.yellow)

            if isToLocationSet {
                Marker(locationManager.toPositionName, systemImage: "location.fill.viewfinder", coordinate: locationManager.toPositionCoordinate)
                    .tint(.indigo)
            }
            
            if locationManager.isPolyline {
                if isDefaultRouteActive {
                    MapPolyline(globalDefaultRoute!.polyline)
                        .stroke(.blue, lineWidth: 5)
                } else {
                    MapPolyline(globalLessCarbonEmissionRoute!.polyline)
                        .stroke(.green, lineWidth: 5)
                }
                // MapPolyline(coordinates: [CLLocationCoordinate2D]
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
                calculateRoute()
                position = .automatic
            }
        }
    }
    
    // MARK: - Calculate route
    private func calculateRoute() {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: locationManager.fromPositionCoordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: locationManager.toPositionCoordinate))
        request.transportType = .automobile
        request.requestsAlternateRoutes = true

        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let response = response {
                let routes = response.routes  
                
                let defaultRoute = routes.first
                let lessCarbonEmissionRoute = routes.max(by: { $0.distance < $1.distance })
                
                
                if let defaultRoute = defaultRoute {
                    globalDefaultRoute = defaultRoute
                }
                
                if let lessCarbonEmissionRoute = lessCarbonEmissionRoute {
                    globalLessCarbonEmissionRoute = lessCarbonEmissionRoute
                }
            } else if let error = error {
                print("Error calculating route: \(error)")
            }
        }
    }
}

#Preview {
    MapView()
        .environmentObject(LocationManager())
}
