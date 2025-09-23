//
//  EditVehicleView.swift
//  VehicleCompanion
//
//  Created by Yurii Petrov on 18.09.2025.
//

import SwiftUI

struct EditVehicleView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Environment(GarageViewModel.self) private var viewModel

    private let vehicle: Vehicle
    private let originalSnapshot: VehicleSnapshot
    @State private var snapshot: VehicleSnapshot
    @State private var vehicleDidChange = false
    @State private var showExitConfirmation = false
    @State private var showDeleteConfirmation = false

    init(vehicle: Vehicle) {
        self.vehicle = vehicle

        originalSnapshot = VehicleSnapshot(vehicle: vehicle)
        _snapshot = State(initialValue: originalSnapshot)
    }

    var body: some View {
        VStack {
            Form {
                TextField("Name", text: $snapshot.name)
                TextField("Make", text: $snapshot.make)
                TextField("Model", text: $snapshot.model)
                TextField(
                    "Year",
                    value: $snapshot.year,
                    formatter: viewModel.yearFormatter
                )
                .keyboardType(.numberPad)
                TextField("VIN", text: $snapshot.vin)
                TextField("Fuel Type", text: $snapshot.fuelType)
            }

            Button("Delete") {
                showDeleteConfirmation.toggle()
            }
        }
        .onChange(of: snapshot) { old, new in
            vehicleDidChange = (originalSnapshot != new)
        }
        .alert("Delete Vehicle?", isPresented: $showDeleteConfirmation, actions: {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                Task { await deleteVehicle() }
            }
        })
        .alert("Discard changes?", isPresented: $showExitConfirmation, actions: {
            Button("Cancel", role: .cancel) {}
            Button("Confirm discard", role: .destructive) {
                dismiss()
            }
        })
        .navigationTitle("Edit Vehicle")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    onCancel()
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    Task { await updateVehicle() }
                }
                .disabled(!vehicleDidChange)
                .opacity(vehicleDidChange ? 1.0 : 0.5)
                .font(.headline)
            }
        }
    }
}

private extension EditVehicleView {
    func deleteVehicle() async {
        do {
            try await viewModel.deleteVehicle(vehicle, in: context)
            dismiss()
        } catch {
            // TODO: Present a user-facing alert if desired
            print("Failed to delete vehicle: \(error)")
        }
    }
    
    func onCancel() {
        if vehicleDidChange {
            showExitConfirmation = true
        } else {
            dismiss()
        }
    }

    func updateVehicle() async {
        do {
            snapshot.apply(to: vehicle)
            try await viewModel.updateVehicle(vehicle, in: context)
            dismiss()
        } catch {
            // TODO: Present a user-facing alert if desired
            print("Failed to update vehicle: \(error)")
        }
    }
}

#Preview {
    EditVehicleView(
        vehicle: Vehicle(
            name: "Family Car",
            make: "Toyota",
            model: "Corolla",
            year: 2015,
            vin: "1HGCM82633A004352",
            fuelType: "Gasoline"
        )
    )
    .environment(GarageViewModel())
}
