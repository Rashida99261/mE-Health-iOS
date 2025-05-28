//
//  PersistenceController.swift
//  mE Health
//
//  Created by Rashida on 28/05/25.
//

import CoreData

class PersistenceController {
    static let shared = PersistenceController()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FHIRTableModel") // same as .xcdatamodeld
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}
