//
//  VehicleCompanionApp.swift
//  VehicleCompanion
//
//  Created by Yurii Petrov on 17.09.2025.
//

import SwiftUI
import SwiftData

@main
struct VehicleCompanionApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: [Vehicle.self])
    }
}
