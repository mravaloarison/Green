//
//  SelectRouteView.swift
//  Green
//
//  Created by Mami Ravaloarison on 11/9/24.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let position = CLLocationCoordinate2D(latitude: 40.75217554712658, longitude: -73.98177565965064)
}

struct SelectRouteView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    @State private var showLocationInputSheet = false
    @State private var isFromLocation = false
    @State private var selectedPlace = Place(mapItem: MKMapItem())
    
    
    @State private var fromLocationCoordinate: CLLocationCoordinate2D = .position
    @State private var toLocationCoordinate: CLLocationCoordinate2D = .position
    
    var body: some View {
        List {
            LocationButton(icon: "location.fill.viewfinder", color: .yellow, label: locationManager.fromPositionName) {
                isFromLocation = true
                showLocationInputSheet = true
            }
            
            LocationButton(icon: "mappin.and.ellipse", color: .indigo, label: locationManager.toPositionName) {
                isFromLocation = false
                showLocationInputSheet = true
            }
            
            Section {
                Button("Get Directions") {
                    print("Get Directions clicked")
                }
                .frame(maxWidth: .infinity)
            }
        }
        .onChange(of: selectedPlace) {
            updateLocationData()
        }
        .sheet(isPresented: $showLocationInputSheet) {
            LocationInputView(returnedPlace: $selectedPlace)
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(18)
        }
    }
    
    // MARK: - Update location data
    private func updateLocationData() {
        let coordinate = selectedPlace.mapItem.placemark.coordinate
        
        if isFromLocation {
            locationManager.fromPositionName = selectedPlace.name
            locationManager.updateCoordinate(isFromLocation: true, to: coordinate)
        } else {
            locationManager.toPositionName = selectedPlace.name
            locationManager.updateCoordinate(isFromLocation: false, to: coordinate)
        }
        
        isFromLocation = false
    }
}

struct LocationButton: View {
    let icon: String
    let color: Color
    let label: String
    let action: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 18) {
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(color)
                .frame(width: 18, height: 18)
            Button(action: action) {
                Text(label)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    SelectRouteView()
        .environmentObject(LocationManager())
}
