//
//  TravelModeBtn.swift
//  Green
//
//  Created by Mami Ravaloarison on 11/9/24.
//

import SwiftUI

struct TravelModeBtn: ButtonStyle {
    let sysImgName: String
    let fgColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        Image(systemName: sysImgName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(fgColor)
            .frame(width: 30, height: 30)
            .padding()
            .background(.thickMaterial)
            .clipShape(Circle())
    }
}
