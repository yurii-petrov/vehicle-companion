//
//  RootView.swift
//  VehicleCompanion
//
//  Created by Yurii Petrov on 17.09.2025.
//

import SwiftUI
import SwiftData

struct RootView: View {
    
    var body: some View {
        TabView {
            GarageView()
                .tabItem { Label("Garage", systemImage: "car.fill") }
            
            PlacesView()
                .tabItem { Label("Places", systemImage: "map.fill") }
        }
    }
}

#Preview {
    let container = try! ModelContainer(
        for: Vehicle.self,
        configurations: .init(isStoredInMemoryOnly: true)
    )
    NavigationStack {
        RootView()
            .onAppear {
                let ctx = ModelContext(container)
                ctx.insert(Vehicle(name: "Family Car", make: "Toyota", model: "Corolla", year: 2015, vin: "1HGCM82633A004352", fuelType: "Gasoline"))
                ctx.insert(Vehicle(name: "EV", make: "Tesla", model: "Model 3", year: 2021, vin: "5YJ3E1EA7KF000000", fuelType: "EV"))
            }
    }
    .modelContainer(container)
}
