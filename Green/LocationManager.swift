//
//  LocationManager.swift
//  Green
//
//  Created by Mami Ravaloarison on 11/9/24.
//

import Foundation
import MapKit

@MainActor
class LocationManager: NSObject, ObservableObject {
    @Published var location: CLLocation?
    @Published var region = MKCoordinateRegion()
    
    @Published var fromPositionCoordinate: CLLocationCoordinate2D = .position
    @Published var toPositionCoordinate: CLLocationCoordinate2D = .position
    
    @Published var fromPositionName: String = "From location"
    @Published var toPositionName: String = "To location"
    
    @Published var isPolyline: Bool = false
    @Published var isGreen: Bool = true
    
    private let locationManager = CLLocationManager()
    private var isInitialLocationSet = false
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    func updateCoordinate(isFromLocation: Bool, to coordinate: CLLocationCoordinate2D) {
        if isFromLocation {
            fromPositionCoordinate = coordinate
        } else {
            toPositionCoordinate = coordinate
        }
        updateRegion(to: coordinate)
    }
    
    func uptdateName(isFromLocation: Bool, to locationName: String) {
        if isFromLocation {
            fromPositionName = locationName
        } else {
            toPositionName = locationName
        }
    }
    
    func updatePolyline() {
        isPolyline.toggle()
    }
    
    func updateGreen() {
        isGreen.toggle()
    }
    
    func updateRegion(to coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        
        if !isInitialLocationSet {
            fromPositionCoordinate = location.coordinate
            isInitialLocationSet = true
        }
    }
}
