//
//  EmissionDetailsView.swift
//  Green
//
//  Created by Mami Ravaloarison on 11/9/24.
//

import SwiftUI

struct EmissionDetailsView: View {    
    @EnvironmentObject var locationManager: LocationManager

    @State private var isGreen: Bool = true
    
    var body: some View {
        VStack {
            Toggle(isOn: $isGreen, label: {
                HStack (spacing: 12) {
                    Image(systemName: "carbon.dioxide.cloud.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(isGreen ? .green : .secondary)
                        .frame(width: 36, height: 36)
                    Text("Save the earth")
                        .font(.title3)
                }
            })
            .toggleStyle(SwitchToggleStyle(tint: .green))
            .onChange(of: isGreen) {
                locationManager.updateGreen()
                print("Location manager has been updated to", locationManager.isGreen)
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    EmissionDetailsView()
        .environmentObject(LocationManager())
}
