//
//  DataPopulation.swift
//  closet-color-id
//
//  Created by Allison Cao on 11/7/22.
//

import Foundation
import CoreData

import Photos
import SwiftUI
import UIKit

// style presets
//professional
//casual
//going out
//+ the gym/dance/street fit — idk what to call this

class DataPopulation: ObservableObject {
  let appDelegate: AppDelegate = AppDelegate()
  let viewModel: ViewModel = ViewModel()

  func populateTopSubcategories(category_id: NSManagedObjectID) {
    let context = appDelegate.persistentContainer.viewContext
    
    if let entity = NSEntityDescription.entity(forEntityName: "Subcategory", in: context) {
      NSLog("created entity")
      NSLog(entity.debugDescription)
      
      // tops
      let longSleeve = NSManagedObject(entity: entity, insertInto: context)
      longSleeve.setValue("long sleeve", forKey: "name")
      longSleeve.setValue(context.object(with: category_id), forKey: "category")
      let shortSleeve = NSManagedObject(entity: entity, insertInto: context)
      shortSleeve.setValue("short sleeve", forKey: "name")
      shortSleeve.setValue(context.object(with: category_id), forKey: "category")
      let buttonUp = NSManagedObject(entity: entity, insertInto: context)
      buttonUp.setValue("button up", forKey: "name")
      buttonUp.setValue(context.object(with: category_id), forKey: "category")
      let blouse = NSManagedObject(entity: entity, insertInto: context)
      blouse.setValue("blouse", forKey: "name")
      blouse.setValue(context.object(with: category_id), forKey: "category")
      let sleeveless = NSManagedObject(entity: entity, insertInto: context)
      sleeveless.setValue("sleeveless", forKey: "name")
      sleeveless.setValue(context.object(with: category_id), forKey: "category")
      
      do {
        try context.save()
        NSLog("Top Subcategories populated")
      } catch {
        NSLog("[Contacts] ERROR: Failed to save Top Subcategories to CoreData")
      }
    }
  }
  
  func populateBottomSubcategories(category_id: NSManagedObjectID) {
    let context = appDelegate.persistentContainer.viewContext
    
    if let entity = NSEntityDescription.entity(forEntityName: "Subcategory", in: context) {
      NSLog("created entity")
      NSLog(entity.debugDescription)
      
      // bottoms
      let pants = NSManagedObject(entity: entity, insertInto: context)
      pants.setValue("pants", forKey: "name")
      pants.setValue(context.object(with: category_id), forKey: "category")
      let shorts = NSManagedObject(entity: entity, insertInto: context)
      shorts.setValue("shorts", forKey: "name")
      shorts.setValue(context.object(with: category_id), forKey: "category")
      let skirt = NSManagedObject(entity: entity, insertInto: context)
      skirt.setValue("skirt", forKey: "name")
      skirt.setValue(context.object(with: category_id), forKey: "category")
      
      do {
        try context.save()
        NSLog("Bottom Subcategories populated")
      } catch {
        NSLog("[Contacts] ERROR: Failed to save Subcategories to CoreData")
      }
    }
  }
  
  func populateFootwearSubcategories(category_id: NSManagedObjectID) {
    let context = appDelegate.persistentContainer.viewContext
    
    if let entity = NSEntityDescription.entity(forEntityName: "Subcategory", in: context) {
      NSLog("created entity")
      NSLog(entity.debugDescription)
      
      // footwear
      let sneaker = NSManagedObject(entity: entity, insertInto: context)
      sneaker.setValue("sneaker", forKey: "name")
      sneaker.setValue(context.object(with: category_id), forKey: "category")
      let dressShoe = NSManagedObject(entity: entity, insertInto: context)
      dressShoe.setValue("dress shoe", forKey: "name")
      dressShoe.setValue(context.object(with: category_id), forKey: "category")
      let sandal = NSManagedObject(entity: entity, insertInto: context)
      sandal.setValue("sandal", forKey: "name")
      sandal.setValue(context.object(with: category_id), forKey: "category")
      let heels = NSManagedObject(entity: entity, insertInto: context)
      heels.setValue("heels", forKey: "name")
      heels.setValue(context.object(with: category_id), forKey: "category")
      
      do {
        try context.save()
        NSLog("Footwear Subcategories populated")
      } catch {
        NSLog("[Contacts] ERROR: Failed to save Subcategories to CoreData")
      }
    }
  }
  
  func populateSubcategories() {
    let context = appDelegate.persistentContainer.viewContext
    
    if let entity = NSEntityDescription.entity(forEntityName: "Subcategory", in: context) {
      NSLog("created entity")
      NSLog(entity.debugDescription)
      
      // fetch categories
      let top_cat = viewModel.fetchCategory(name: "top")
      let bottom_cat = viewModel.fetchCategory(name: "bottom")
      let foot_cat = viewModel.fetchCategory(name: "footwear")
      let outer_cat = viewModel.fetchCategory(name: "outerwear")
      
      // tops
      let longSleeve = NSManagedObject(entity: entity, insertInto: context)
      longSleeve.setValue("long sleeve", forKey: "name")
      longSleeve.setValue(top_cat, forKey: "category")
      let shortSleeve = NSManagedObject(entity: entity, insertInto: context)
      shortSleeve.setValue("short sleeve", forKey: "name")
      shortSleeve.setValue(top_cat, forKey: "category")
      let buttonUp = NSManagedObject(entity: entity, insertInto: context)
      buttonUp.setValue("button up", forKey: "name")
      buttonUp.setValue(top_cat, forKey: "category")
      let blouse = NSManagedObject(entity: entity, insertInto: context)
      blouse.setValue("blouse", forKey: "name")
      blouse.setValue(top_cat, forKey: "category")
      let sleeveless = NSManagedObject(entity: entity, insertInto: context)
      sleeveless.setValue("sleeveless", forKey: "name")
      sleeveless.setValue(top_cat, forKey: "category")
      
      // bottoms
      let pants = NSManagedObject(entity: entity, insertInto: context)
      pants.setValue("pants", forKey: "name")
      pants.setValue(bottom_cat, forKey: "category")
      let shorts = NSManagedObject(entity: entity, insertInto: context)
      shorts.setValue("shorts", forKey: "name")
      shorts.setValue(bottom_cat, forKey: "category")
      let skirt = NSManagedObject(entity: entity, insertInto: context)
      skirt.setValue("skirt", forKey: "name")
      skirt.setValue(bottom_cat, forKey: "category")
      
      // footwear
      let sneaker = NSManagedObject(entity: entity, insertInto: context)
      sneaker.setValue("sneaker", forKey: "name")
      sneaker.setValue(foot_cat, forKey: "category")
      let dressShoe = NSManagedObject(entity: entity, insertInto: context)
      dressShoe.setValue("dress shoe", forKey: "name")
      dressShoe.setValue(foot_cat, forKey: "category")
      let sandal = NSManagedObject(entity: entity, insertInto: context)
      sandal.setValue("sandal", forKey: "name")
      sandal.setValue(foot_cat, forKey: "category")
      let heels = NSManagedObject(entity: entity, insertInto: context)
      heels.setValue("heels", forKey: "name")
      heels.setValue(foot_cat, forKey: "category")
      
      do {
        try context.save()
        
      } catch {
        NSLog("[Contacts] ERROR: Failed to save Subcategories to CoreData")
      }
    }
  }
  
  func populateCategories() {
    let context = appDelegate.persistentContainer.viewContext
    
    if let entity = NSEntityDescription.entity(forEntityName: "Category", in: context) {
      NSLog("created entity")
      NSLog(entity.debugDescription)
      let topVal = NSManagedObject(entity: entity, insertInto: context)
      topVal.setValue("top", forKey: "name")
      
      let bottomVal = NSManagedObject(entity: entity, insertInto: context)
      bottomVal.setValue("bottom", forKey: "name")
      
      let footVal = NSManagedObject(entity: entity, insertInto: context)
      footVal.setValue("footwear", forKey: "name")
      
      let outerVal = NSManagedObject(entity: entity, insertInto: context)
      outerVal.setValue("outerwear", forKey: "name")
      do {
        try context.save()
        
      } catch {
        NSLog("[Contacts] ERROR: Failed to save Category to CoreData")
      }
    }
  }
}
