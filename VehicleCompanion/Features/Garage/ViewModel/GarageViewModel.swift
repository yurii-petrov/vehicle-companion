//
//  GarageViewModel.swift
//  VehicleCompanion
//
//  Created by Yurii Petrov on 20.09.2025.
//

import Foundation
import SwiftData

@MainActor
@Observable
final class GarageViewModel {
    
    func addVehicle(_ vehicle: Vehicle, in context: ModelContext) {
        context.insert(vehicle)
        
        do {
            try context.save()
        } catch {
            // TODO: present error UI if needed
        }
    }
    
    func deleteVehicle(_ vehicle: Vehicle, in context: ModelContext) async throws {
        context.delete(vehicle)
        
        do {
            try context.save()
        } catch {
            // TODO: present error UI if needed
        }
    }
    
    func updateVehicle(_ vehicle: Vehicle, in context: ModelContext) async throws {
        do {
            try context.save()
        } catch {
            // TODO: present error UI if needed
        }
    }
    
    let yearFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .none
        f.maximumFractionDigits = 0
        return f
    }()
}

