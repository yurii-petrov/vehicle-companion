import Foundation
import SwiftData

@Model
final class Vehicle {
    @Attribute(.unique) var id: UUID
    var name: String
    var make: String
    var model: String
    var year: Int
    var vin: String
    var fuelType: String
    var heroImageData: Data?

    init(
        id: UUID = UUID(),
        name: String,
        make: String,
        model: String,
        year: Int,
        vin: String,
        fuelType: String,
        heroImageData: Data? = nil
    ) {
        self.id = id
        self.name = name
        self.make = make
        self.model = model
        self.year = year
        self.vin = vin
        self.fuelType = fuelType
        self.heroImageData = heroImageData
    }
}
