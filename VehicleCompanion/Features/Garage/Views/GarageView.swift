//
//  GarageView.swift
//  VehicleCompanion
//
//  Created by Yurii Petrov on 17.09.2025.
//

import SwiftUI
import SwiftData

struct GarageView: View {
    @Query var vehicles: [Vehicle]

    var body: some View {
      Group {
        if vehicles.isEmpty { GarageEmptyView() }
        else {
          List(vehicles) { VehicleRowView(vehicle: $0) }
            .listStyle(.insetGrouped)
        }
      }
      .navigationTitle("Garage")
    }
}

struct GarageEmptyView: View {
  var body: some View {
    ContentUnavailableView("No vehicles yet", systemImage: "car")
  }
}

struct VehicleRowView: View {
  let vehicle: Vehicle
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(vehicle.name).font(.headline)
      Text("\(vehicle.make) \(vehicle.model) • \(vehicle.year)")
        .font(.subheadline).foregroundStyle(.secondary)
    }
    .accessibilityLabel("\(vehicle.name), \(vehicle.make) \(vehicle.model), \(vehicle.year)")
  }
}


#Preview {
    NavigationStack { GarageView() }
        .modelContainer(for: [Vehicle.self], inMemory: true)
}
