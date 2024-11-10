//
//  EmissionDetailsView.swift
//  Green
//
//  Created by Mami Ravaloarison on 11/9/24.
//

import SwiftUI

struct EmissionDetailsView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    @State private var timeEstimated: TimeInterval = 0.0
    @State private var savedCarbonFP: Float = 6.3

    var body: some View {
        if locationManager.isPolyline {
            VStack(spacing: 16) {
                GreenToggle(isOn: $locationManager.isGreen)
                Details(isGreen: $locationManager.isGreen, savedCarbonFP: $savedCarbonFP, timeEstimated: formattedTime())

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        if locationManager.isGreen {
                            if let greenRoute = locationManager.GreenRoute {
                                ForEach(greenRoute.steps.dropFirst(), id: \.self) { step in
                                    Text(step.instructions)
                                        .font(.title2)
                                    Divider()
                                }
                            }
                        } else {
                            if let defaultRoute = locationManager.defaultRoute {
                                ForEach(defaultRoute.steps.dropFirst(), id: \.self) { step in
                                    Text(step.instructions)
                                        .font(.title2)
                                    Divider()
                                }
                            }
                        }

                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.thinMaterial)
                    .cornerRadius(12)
                }

                Spacer()
            }
            .padding()
            .onAppear {
                updateEstimatedTime()
            }
            .onChange(of: locationManager.isGreen) { 
                updateEstimatedTime()
            }
        } else {
            VStack(spacing: 20) {
                Image(systemName: "info.circle")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.secondary)
                Text("There is no details to display yet")
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    private func updateEstimatedTime() {
        if locationManager.isGreen, let greenRoute = locationManager.GreenRoute {
            timeEstimated = greenRoute.expectedTravelTime
        } else if let defaultRoute = locationManager.defaultRoute {
            timeEstimated = defaultRoute.expectedTravelTime
        }
    }
    
    private func formattedTime() -> String {
        let minutes = Int(timeEstimated / 60)
        return "\(minutes) min"
    }
}

struct Details: View {
    @Binding var isGreen: Bool
    @Binding var savedCarbonFP: Float
    var timeEstimated: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(timeEstimated)
                Spacer()
                Image(systemName: "leaf.fill")
                    .foregroundColor(isGreen ? .green : .secondary)
            }
            HStack(alignment: .bottom) {
                Text("\(savedCarbonFP, specifier: "%.1f") lbs")
                    .font(.title)
                if isGreen {
                    Text("traffic emission avoided")
                        .foregroundColor(.green)
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.green)
                } else {
                    Text("avg of CO2")
                        .foregroundColor(.secondary)
                    Image(systemName: "smoke.fill")
                        .foregroundColor(.secondary)
                }
            }
            if isGreen {
                Text("(+ 23 points)")
                    .font(.callout)
                    .foregroundColor(.brown)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.thinMaterial)
        .cornerRadius(12)
    }
}

struct GreenToggle: View {
    @Binding var isOn: Bool

    var body: some View {
        Toggle(isOn: $isOn) {
            HStack(spacing: 12) {
                Image(systemName: "carbon.dioxide.cloud.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(isOn ? .green : .secondary)
                    .frame(width: 36, height: 36)
                Text("Save the Earth")
                    .font(.title3)
                    .foregroundColor(isOn ? .primary : .secondary)
            }
        }
        .toggleStyle(SwitchToggleStyle(tint: .green))
        .onChange(of: isOn) {
            print("Green mode is now \(isOn ? "enabled" : "disabled")")
        }
    }
}

#Preview {
    EmissionDetailsView()
        .environmentObject(LocationManager())
}
