//
//  GreenApp.swift
//  Green
//
//  Created by Mami Ravaloarison on 11/9/24.
//

import SwiftUI

@main
struct GreenApp: App {
    var body: some Scene {
        @StateObject var locationManager = LocationManager()
        
        WindowGroup {
            ContentView()
                .environmentObject(locationManager)
        }
    }
}
