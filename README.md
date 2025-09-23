# VehicleCompanion

A SwiftUI app that manages a list of vehicles using SwiftData.

## Running
- Xcode: Use an Xcode version that includes the iOS 17 SDK or newer (required for SwiftData).
- iOS target: iOS 17 or later (SwiftData requirement).
- Steps:
  1. Open the project in Xcode.
  2. Select an iOS simulator or device running iOS 17+.
  3. Build & Run.
- Notes: SwiftUI previews use in-memory SwiftData containers in this project.

## Architecture & design choices
- SwiftUI-first UI with `NavigationStack`.
- Data access with SwiftData `@Query(sort: \Vehicle.name)` in `GarageView`.
- Mutations via `@Environment(\.modelContext)`.
- Light MVVM: `GarageView` owns a `GarageViewModel` (`@State private var viewModel = GarageViewModel()`) and injects it with `.environment(viewModel)`.
- Navigation & presentation:
  - `navigationDestination(for: Vehicle.self)` to edit a selected vehicle (`EditVehicleView`).
  - `.sheet(isPresented:)` to add a vehicle (`AddVehicleView`).
- List interactions:
  - `List` of vehicles with `VehicleRowView` inside a `NavigationLink`.
  - `swipeActions` for delete.

## Data modeling
- Observed model: `Vehicle` (SwiftData model type referenced across the code).
- Observed properties (from preview insertions): `name`, `make`, `model`, `year`, `vin`, `fuelType`.
- Current rationale (from usage): A single `Vehicle` entity supports the current list-and-edit UI.
- Future work: If the app grows (e.g., maintenance logs, charging sessions), additional related entities can be added.

## Error/empty state handling
- Empty state: When there are no `Vehicle` items, `GarageEmptyView` shows a `ContentUnavailableView` with an "Add Vehicle" action.
- Delete errors: Deletion runs in a `Task` and errors are caught and printed. There is a TODO to surface user-facing error UI.
- Future work: Add user-visible error presentation (e.g., alert/toast) and input validation in add/edit flows.

## Future Plans
- User-facing error alerts and validation for add/edit.
- A dedicated vehicle detail screen.
- Additional data (future): service/maintenance records, odometer entries, charging sessions (if applicable), each related to `Vehicle`.
- Search and filtering in the garage list.
- Tests using in-memory SwiftData containers for view model logic and basic UI flows.
