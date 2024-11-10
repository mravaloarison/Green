//
//  ContentView.swift
//  Green
//
//  Created by Mami Ravaloarison on 11/9/24.
//

import SwiftUI

enum SelectedMenu {
    case carTypes
    case route
    case emissionDetails
}

struct ContentView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    @State private var selectedMenu: SelectedMenu? = nil
    
    private var isSheetPresented: Binding<Bool> {
        Binding(
            get: { selectedMenu != nil },
            set: { newValue in
                if !newValue { selectedMenu = nil }
            }
        )
    }

    var body: some View {
        ZStack {
            MapView()
                .safeAreaInset(edge: .bottom, content: {
                    HStack(spacing: 12) {
                        ButtonList(
                            selectedMenu: $selectedMenu
                        )
                    }
                    .padding()
                })
                .sheet(isPresented: isSheetPresented) {
                    VStack {
                        switch selectedMenu {
                            case .carTypes:
                                SelectCarView()
                                    .presentationDetents([.fraction(0.30)])
                            case .route:
                                SelectRouteView()
                                    .presentationDetents([.fraction(0.33)])
                                    .presentationDragIndicator(.visible)
                            case .emissionDetails:
                                EmissionDetailsView()
                                    .presentationDetents([.medium, .large])
                            default:
                                Text("Select an option")
                        }
                    }
                    .presentationCornerRadius(18)
                }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(LocationManager())
}
