//
//  VehicleRowView.swift
//  VehicleCompanion
//
//  Created by Yurii Petrov on 21.09.2025.
//
import SwiftUI

struct VehicleRowView: View {
    let vehicle: Vehicle
    var body: some View {
        HStack(spacing: 12) {
            VehicleThumbnail(data: vehicle.heroImageData)
            VStack(alignment: .leading, spacing: 4) {
                Text(vehicle.name).font(.headline)
                Text("\(vehicle.make) \(vehicle.model) • \(vehicle.year)")
                    .font(.subheadline).foregroundStyle(.secondary)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(
            "\(vehicle.name), \(vehicle.make) \(vehicle.model), \(vehicle.year)"
        )
        .accessibilityHint("Opens editor")
    }
}

struct VehicleThumbnail: View {
    let data: Data?
    var size: CGFloat = 44
    var body: some View {
        Group {
            if let d = data, let img = UIImage(data: d) {
                // TODO: Make it AsyncImage
                Image(uiImage: img).resizable().scaledToFill()
            } else {
                Image(systemName: "car.fill")
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(width: size, height: size)
        .background(
            RoundedRectangle(cornerRadius: 8).fill(.secondary.opacity(0.1))
        )
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    VehicleRowView(vehicle: Vehicle(name: "Family Car", make: "Toyota", model: "Corolla", year: 2015, vin: "1HGCM82633A004352", fuelType: "Gasoline"))
}
