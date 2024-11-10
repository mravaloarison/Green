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
    @State private var savedCarbonFP: Float = 0.0
    @State private var pointsEarned: Float = 0.0

    var body: some View {
        if locationManager.isPolyline {
            VStack(spacing: 16) {
                GreenToggle(isOn: $locationManager.isGreen)
                Details(isGreen: $locationManager.isGreen, savedCarbonFP: $savedCarbonFP, pointsEarned: $pointsEarned, timeEstimated: formattedTime())

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
                updateEmissionsAndPoints()
            }
            .onChange(of: locationManager.isGreen) {
                updateEstimatedTime()
                updateEmissionsAndPoints()
            }
        } else {
            VStack(spacing: 20) {
                Image(systemName: "info.circle")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.secondary)
                Text("There are no details to display yet")
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

    private func updateEmissionsAndPoints() {
        let minutes = timeEstimated / 60.0
        // Emission formula based on reference points
        savedCarbonFP = Float(10.93 - 0.186 * minutes)
        pointsEarned = Float(savedCarbonFP * 10)  // Each lb saved = 10 points, adjust as needed
    }
}

struct Details: View {
    @Binding var isGreen: Bool
    @Binding var savedCarbonFP: Float
    @Binding var pointsEarned: Float
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
                Text("\(savedCarbonFP, specifier: "%.2f") lbs")
                    .font(.title)
                if isGreen {
                    Text("traffic emission avoided")
                        .foregroundColor(.green)
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.green)
                } else {
                    Text("avg CO₂")
                        .foregroundColor(.secondary)
                    Image(systemName: "smoke.fill")
                        .foregroundColor(.secondary)
                }
            }
            if isGreen {
                Text("(+ \(Int(pointsEarned)) points)")
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
