//
//  ButtonList.swift
//  Green
//
//  Created by Mami Ravaloarison on 11/9/24.
//

import SwiftUI

struct ButtonList: View {
    @Binding var selectedMenu: SelectedMenu?

    var body: some View {
        let buttons = [
            ButtonData(iconName: "car.fill", color: .brown) {
                selectedMenu = .carTypes
            },
            ButtonData(iconName: "map.fill", color: .cyan) {
                selectedMenu = .route
            },
            ButtonData(iconName: "carbon.dioxide.cloud.fill", color: .green) {
                selectedMenu = .emissionDetails
            }
        ]
        
        HStack(spacing: 12) {
            ForEach(buttons.indices, id: \.self) { index in
                TravelModeButton(buttonData: buttons[index])
            }
        }
    }
}
