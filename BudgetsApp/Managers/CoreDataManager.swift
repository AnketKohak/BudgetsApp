//
//  CoreDataManager.swift
//  BudgetsApp
//
//  Created by Anket Kohak on 07/10/24.
//

import Foundation
import CoreData


class CoreDataManager {
    static let shared = CoreDataManager()
    private var persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "BudgetModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("unable to initialize Core Data stack: \(error)")
            }
        }
    }
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}
