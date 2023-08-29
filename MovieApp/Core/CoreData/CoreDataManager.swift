//
//  CoreDataManager.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 18.08.23.
//

import Foundation
import CoreData


class CoreDataManager<Entity: NSManagedObject> {

    var viewContext: NSManagedObjectContext {
        AppDelegate.coreDataContainer.viewContext
    }

    // MARK: - Core Data operations
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    func fetch(entityName: String, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> [Entity] {
        let fetchRequest = NSFetchRequest<Entity>(entityName: entityName)
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors

        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch entities: \(error)")
            return []
        }
    }
}
