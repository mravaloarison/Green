//
//  PlaceVM.swift
//  Green
//
//  Created by Mami Ravaloarison on 11/9/24.
//

import Foundation
import MapKit

class PlaceVM: ObservableObject {
    @Published var placesFound: [Place] = []
    
    func search(text: String, region: MKCoordinateRegion) {
        let req = MKLocalSearch.Request()
        req.naturalLanguageQuery = text
        req.region = region
        let search = MKLocalSearch(request: req)
        
        search.start { response, error in
            guard let res = response else {
                print("PlaceVM error \(String(describing: error))")
                return
            }
            
            self.placesFound = res.mapItems.map(Place.init)
        }
    }
}

