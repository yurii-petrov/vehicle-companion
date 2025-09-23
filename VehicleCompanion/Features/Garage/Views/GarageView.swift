//
//  GarageView.swift
//  VehicleCompanion
//
//  Created by Yurii Petrov on 17.09.2025.
//

import SwiftUI
import SwiftData

struct GarageView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Vehicle.name) private var vehicles: [Vehicle]
    
    @State private var viewModel = GarageViewModel()

    @State private var editing: Vehicle? = nil
    @State private var showAddVehicleView = false

    var body: some View {
        NavigationStack {
        Group {
            if vehicles.isEmpty {
                GarageEmptyView { showAddVehicleView = true }
            } else {
                    List {
                        ForEach(vehicles) { vehicle in
                            NavigationLink(value: vehicle) {
                                VehicleRowView(vehicle: vehicle)
                                    .swipeActions {
                                        Button {
                                            Task {
                                                do {
                                                    try await viewModel.deleteVehicle(vehicle, in: context)
                                                } catch {
                                                    // TODO: Surface an error UI if needed
                                                    print("Failed to delete vehicle: \(error)")
                                                }
                                            }
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                        .tint(.red)
                                    }
                            }
                        }
                    }
                }
        }
        .navigationDestination(for: Vehicle.self) { vehicle in
            EditVehicleView(vehicle: vehicle)
                .environment(viewModel)
        }
        .sheet(isPresented: $showAddVehicleView) {
            AddVehicleView()
                .environment(viewModel)
                .presentationDetents([.medium])
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button { showAddVehicleView = true } label: {
                    Label("Add Vehicle", systemImage: "plus")
                }
            }
        }
        .navigationTitle("Garage")
        }
    }
}

struct GarageEmptyView: View {
    var onAdd: () -> Void
    var body: some View {
        ContentUnavailableView {
            Label("No vehicles yet", systemImage: "car")
        } actions: {
            Button("Add Vehicle", action: onAdd)
        }
    }
}


#Preview("List") {
    let container = try! ModelContainer(
        for: Vehicle.self,
        configurations: .init(isStoredInMemoryOnly: true)
    )
    let ctx = ModelContext(container)
    ctx.insert(Vehicle(name: "Family Car", make: "Toyota", model: "Corolla", year: 2015, vin: "1HGCM82633A004352", fuelType: "Gasoline"))
    ctx.insert(Vehicle(name: "EV", make: "Tesla", model: "Model 3", year: 2021, vin: "5YJ3E1EA7KF000000", fuelType: "EV"))
    
    return NavigationStack { GarageView() }
        .modelContainer(container)
}

#Preview("Empty") {
    return NavigationStack { GarageView() }
        .modelContainer(for: [Vehicle.self], inMemory: true)
}

