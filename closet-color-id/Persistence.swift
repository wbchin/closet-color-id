//
//  File.swift
//  closet-color-id
//
//  Created by Allison Cao on 11/7/22.
//

import Foundation
import CoreData
struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    init() {
        container = NSPersistentContainer(name: "closet-color-id")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Container load failed: \(error)")
            }
        }
    }
}
