//
//  TestCoreDataStack.swift
//  closet-color-idTests
//
//  Created by Allison Cao on 12/1/22.
//

import Foundation
import CoreData

final class TestCoreDataStack: NSObject {
    lazy var persistentContainer: NSPersistentContainer = {
            let description = NSPersistentStoreDescription()
            description.url = URL(fileURLWithPath: "/dev/null")
            let container = NSPersistentContainer(name: "closet-color-id")
            container.persistentStoreDescriptions = [description]
            container.loadPersistentStores { _, error in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            }
            return container
    }()

}
