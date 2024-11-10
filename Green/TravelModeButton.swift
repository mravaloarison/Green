//
//  TravelModeButton.swift
//  Green
//
//  Created by Mami Ravaloarison on 11/9/24.
//

import SwiftUI

struct TravelModeButton: View {
    let buttonData: ButtonData

    var body: some View {
        Button("") {
            buttonData.action()
        }
        .buttonStyle(TravelModeBtn(sysImgName: buttonData.iconName, fgColor: buttonData.color))
    }
}
