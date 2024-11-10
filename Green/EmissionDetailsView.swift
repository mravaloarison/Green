//
//  EmissionDetailsView.swift
//  Green
//
//  Created by Mami Ravaloarison on 11/9/24.
//

import SwiftUI

struct EmissionDetailsView: View {
    @State private var isCarbonFootprintActive: Bool = true
    
    var body: some View {
        VStack {
            Toggle(isOn: $isCarbonFootprintActive, label: {
                HStack (spacing: 12) {
                    Image(systemName: "carbon.dioxide.cloud.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(isCarbonFootprintActive ? .green : .secondary)
                        .frame(width: 36, height: 36)
                    Text("Save the earth")
                        .font(.title3)
                }
            })
            .toggleStyle(SwitchToggleStyle(tint: .green))
            Spacer()
        }
        .padding()
    }
}

#Preview {
    EmissionDetailsView()
}
