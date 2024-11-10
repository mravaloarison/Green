//
//  LocationInputView.swift
//  Green
//
//  Created by Mami Ravaloarison on 11/9/24.
//

import SwiftUI
import MapKit

struct LocationInputView: View {
    @EnvironmentObject var locationManager: LocationManager

    @State private var findLocationInput = ""
    @FocusState private var isSearchFieldFocused: Bool
    
    @StateObject var placeVM = PlaceVM()
    @Environment(\.dismiss) private var dismiss
    
    @Binding var returnedPlace: Place
    
    var body: some View {
        NavigationView {
            List(placeVM.placesFound){ place in
                Button {
                    print("Selected", place)
                    returnedPlace = place
                    dismiss()
                } label: {
                    VStack (alignment: .leading) {
                        Text(place.name)
                        Text(place.address)
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .searchable(text: $findLocationInput)
            // TODO: Focused on show
            .focused($isSearchFieldFocused)
            .listStyle(.plain)
            .onChange(of: findLocationInput) {
                if !findLocationInput.isEmpty {
                    placeVM.search(text: findLocationInput, region: locationManager.region)
                } else {
                    placeVM.placesFound = []
                }
            }
        }
        .padding(.vertical)
        .onAppear {
            isSearchFieldFocused = true
        }
    }
}

#Preview {
    LocationInputView(returnedPlace: .constant(Place(mapItem: MKMapItem())))
        .environmentObject(LocationManager())
}
