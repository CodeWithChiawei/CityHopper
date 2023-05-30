//
//  CoreDataStack.swift
//  CityHopper
//
//  Created by chiawei wen on 3/29/23.
//

import Foundation
import CoreData

enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores { _, error in
            if let error = error {
                print(error)
                return
            }
        }
        return container
    }()
    
    static let context = container.viewContext
}
