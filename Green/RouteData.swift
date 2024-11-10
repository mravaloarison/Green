//
//  RouteData.swift
//  Green
//
//  Created by Mami Ravaloarison on 11/9/24.
//

import SwiftUI
import MapKit

class RouteData: ObservableObject {
    @Published var fromLocationName: String = "From location"
    @Published var toLocationName: String = "To Location"
    @Published var fromLocationCoordinate: CLLocationCoordinate2D = .position
    @Published var toLocationCoordinate: CLLocationCoordinate2D = .position
}
