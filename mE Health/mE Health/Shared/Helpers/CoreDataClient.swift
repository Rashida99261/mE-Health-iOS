//
//  CoreDataClient.swift
//  mE Health
//
//  Created by Rashida on 28/05/25.
//

import ComposableArchitecture

struct CoreDataClient {
    var savePatient: (Patient) throws -> Void
}

enum CoreDataError: Error {
    case saveFailed
}

extension DependencyValues {
    var coreDataClient: CoreDataClient {
        get { self[CoreDataClientKey.self] }
        set { self[CoreDataClientKey.self] = newValue }
    }
}

private enum CoreDataClientKey: DependencyKey {
    static let liveValue: CoreDataClient = .live
}

extension CoreDataClient {
    static let live = CoreDataClient(
        savePatient: { patient in
            let context = PersistenceController.shared.context

            let entity = PatientEntity(context: context)
            entity.id = patient.id ?? "1"
            entity.name = (patient.name?.first?.given?.joined(separator: " ") ?? "") + " " + (patient.name?.first?.family ?? "")
            entity.gender = "Male"
            entity.birthDate = "1993-07-15"
            do {
                try context.save()
                print("✅ Saved patient to Core Data")
            } catch {
                print("❌ Core Data save failed: \(error)")
                throw CoreDataError.saveFailed
            }
        }
    )
}
