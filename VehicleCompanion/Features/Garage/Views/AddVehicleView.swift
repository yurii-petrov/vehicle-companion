//
//  AddVehicleView.swift
//  VehicleCompanion
//
//  Created by Yurii Petrov on 18.09.2025.
//

import SwiftUI

struct AddVehicleView: View {
    @Environment(\.modelContext) private var context
    @Environment(GarageViewModel.self) private var viewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var make: String = ""
    @State private var model: String = ""
    @State private var year: String = ""
    @State private var vin: String = ""
    @State private var fuelType: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                TextField("Make", text: $make)
                TextField("Model", text: $model)
                TextField("Year", text: $year)
                TextField("VIN", text: $vin)
                TextField("Fuel Type", text: $fuelType)
            }
            .navigationTitle("Add Vehicle")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        addVehicle()
                        dismiss()
                    }
                    .font(.headline)
                }
            }
        }
    }
}

private extension AddVehicleView {
    func addVehicle() {
        let newVehicle = Vehicle(
            name: name,
            make: make,
            model: model,
            year: Int(year) ?? 0,
            vin: vin,
            fuelType: fuelType
        )
            
        viewModel.addVehicle(newVehicle, in: context)
    }
}

#Preview {
    AddVehicleView()
        .environment(GarageViewModel())
}
