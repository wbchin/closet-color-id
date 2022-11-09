////
////  CoreDataPersistence.swift
////  closet-color-id
////
////  Created by Allison Cao on 11/8/22.
////
//
//import Foundation
//import CoreData
//
//class CoreDataPersistence: ObservableObject{
//    let appDelegate: AppDelegate = AppDelegate()
//
//    //Use preview context in canvas/preview
//    //The setup for this is in XCode when you create a new project
//    let context = appDelegate.persistentContainer.viewContext
//
//    init(){
//        //Observe all the changes in the context, then refresh the View that observes this using @StateObject, @ObservedObject or @EnvironmentObject
//        //There are other options, like NSPersistentStoreCoordinatorStoresDidChange for the coordinator
//        // https://developer.apple.com/documentation/foundation/nsnotification/name/1506884-nsmanagedobjectcontextobjectsdid
//        NotificationCenter.default.addObserver(self, selector: #selector(refreshView), name: Notification.Name.NSManagedObjectContextObjectsDidChange, object: nil)
//    }
//    ///Creates an NSManagedObject of any type
//    func create<T: NSManagedObject>() -> T{
//        T(context: context)
//        //Can set any defaults in awakeFromInsert() in an extension for the Entity
//        //or override this method using the specific type
//    }
//    ///Updates an NSManagedObject of any type
//    func update<T: NSManagedObject>(_ obj: T){
//        //Make any changes like a last modified variable
//        save()
//    }
//    ///Creates a sample
//    func addSample<T: NSManagedObject>() -> T{
//
//        return create()
//    }
//    ///Deletes  an NSManagedObject of any type
//    func delete(_ obj: NSManagedObject){
//        context.delete(obj)
//        save()
//    }
//    func resetStore(){
//        context.rollback()
//        save()
//    }
//    internal func save(){
//        do{
//            try context.save()
//        }catch{
//            print(error)
//        }
//    }
//    @objc
//    func refreshView(){
//        objectWillChange.send()
//    }
//}
