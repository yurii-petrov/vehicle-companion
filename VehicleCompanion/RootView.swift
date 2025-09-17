//
//  RootView.swift
//  VehicleCompanion
//
//  Created by Yurii Petrov on 17.09.2025.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            NavigationStack { GarageView() }
                .tabItem { Label("Garage", systemImage: "car.fill") }
            
            NavigationStack { PlacesView() }
                .tabItem { Label("Places", systemImage: "map.fill") }
        }
    }
}

#Preview {
    RootView()
}
