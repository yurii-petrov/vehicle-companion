//
//  VehicleSnapshot.swift
//  VehicleCompanion
//
//  Created by Yurii Petrov on 22.09.2025.
//

import Foundation

struct VehicleSnapshot: Equatable {
    var name: String
    var make: String
    var model: String
    var year: Int
    var vin: String
    var fuelType: String

    init(vehicle: Vehicle) {
        name = vehicle.name
        make = vehicle.make
        model = vehicle.model
        year = vehicle.year
        vin = vehicle.vin
        fuelType = vehicle.fuelType
    }

    @discardableResult
    func apply(to v: Vehicle) -> Vehicle {
        v.name = name
        v.make = make
        v.model = model
        v.year = year
        v.vin = vin
        v.fuelType = fuelType
        return v
    }
}
