//
//  SelectCarView.swift
//  Green
//
//  Created by Mami Ravaloarison on 11/9/24.
//

import SwiftUI

struct SelectCarView: View {
    @State private var seasons = ["Gasoline", "Electric", "Hybrid", "Diesel"]
    @State private var selectedSeason = "Diesel"
    
    var body: some View {
        List {
            Picker("emission type", selection: $selectedSeason) {
                ForEach(seasons, id: \.self) { season in
                    Text(season)
                }
            }
            .pickerStyle(.inline)
            .onChange(of: selectedSeason, {
                print(selectedSeason, "selected")
            })
        }
    }
}

#Preview {
    SelectCarView()
}

