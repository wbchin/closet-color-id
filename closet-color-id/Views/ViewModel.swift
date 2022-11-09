//
//  ViewModel.swift
//  closet-color-id
//
//  Created by Allison Cao on 11/3/22.
//

import Foundation
import CoreData

import Photos
import SwiftUI
import UIKit

class ViewModel: ObservableObject {
  @FetchRequest(entity: Article.entity(), sortDescriptors: [])
  var articles: FetchedResults<Article>
  let appDelegate: AppDelegate = AppDelegate()
  let image: UIImage = UIImage(named: "pusheen.png")!
  var image_data : Data {
    get {
      return image.pngData()!
    }
  }
  
  func fetchArticles() -> [Article]? {
    let fetchRequest: NSFetchRequest<Article>
    fetchRequest = Article.fetchRequest()
    
    // Get a reference to a NSManagedObjectContext
    let context = appDelegate.persistentContainer.viewContext
    do {
      let objects = try context.fetch(fetchRequest)
      return objects
    } catch {
      print("Error")
      return nil
    }
  }
  
  func fetchOutfits() -> [Outfit]? {
    let fetchRequest: NSFetchRequest<Outfit>
    fetchRequest = Outfit.fetchRequest()
    
    // Get a reference to a NSManagedObjectContext
    let context = appDelegate.persistentContainer.viewContext
    do {
      let objects = try context.fetch(fetchRequest)
      return objects
    } catch {
      print("Error")
      return nil
    }
  }
  
  func fetchStyles() -> [Style]? {
    let fetchRequest: NSFetchRequest<Style>
    fetchRequest = Style.fetchRequest()
    
    // Get a reference to a NSManagedObjectContext
    let context = appDelegate.persistentContainer.viewContext
    do {
      let objects = try context.fetch(fetchRequest)
      return objects
    } catch {
      print("Error")
      return nil
    }
  }
  
  
  func tagArticleCategory(category_id: NSManagedObjectID, article_id: NSManagedObjectID) {
    let context = appDelegate.persistentContainer.viewContext
    context.object(with: article_id).setValue(context.object(with: category_id), forKey: "category")
    do {
      try context.save()
      NSLog("saved article as category")
      
    } catch {
      NSLog("[Contacts] ERROR: Failed to save Article to CoreData")
    }
  }
  
  func tagArticleSubcategory(subcategory_id: NSManagedObjectID, article_id: NSManagedObjectID) {
    let context = appDelegate.persistentContainer.viewContext
    if let entity = NSEntityDescription.entity(forEntityName: "SubcategoryArticle", in: context) {
      let newVal = NSManagedObject(entity: entity, insertInto: context)
      newVal.setValue(context.object(with: article_id), forKey: "article")
      newVal.setValue(context.object(with: subcategory_id), forKey: "subcategory")
      NSLog("Set all values for newVal")
      do {
        try context.save()
        NSLog("Saved article subcategory")
      } catch {
        NSLog("[Contacts] ERROR: Failed to save Article to CoreData")
      }
    }
  }
  
  func saveArticle() {
    let context = appDelegate.persistentContainer.viewContext
    if let entity = NSEntityDescription.entity(forEntityName: "Article", in: context) {
      NSLog("created entity")
      NSLog(entity.debugDescription)
      let newVal = NSManagedObject(entity: entity, insertInto: context)
      NSLog("created newVal")
      newVal.setValue(self.image_data, forKey: "image_data")
      newVal.setValue("blue test", forKey: "primary_color_name")
      newVal.setValue("diff refresh", forKey: "primary_color_family")
      newVal.setValue("test", forKey: "primary_color_hex")
      newVal.setValue("test", forKey: "secondary_color_name")
      newVal.setValue("test", forKey: "secondary_color_family")
      newVal.setValue("test", forKey: "secondary_color_hex")
      newVal.setValue("test", forKey: "complimentary_color_name")
      newVal.setValue("test", forKey: "complimentary_color_family")
      newVal.setValue("test", forKey: "complimentary_color_hex")
      newVal.setValue("top", forKey: "category")
      newVal.setValue("blouse", forKey: "subcategory")
      NSLog("Set all values for newVal")
      do {
        try context.save()
        context.refreshAllObjects()
        
      } catch {
        NSLog("[Contacts] ERROR: Failed to save Article to CoreData")
      }
    }
  }
  
  func saveOutfit(name: String) {
    let context = appDelegate.persistentContainer.viewContext
    if let entity = NSEntityDescription.entity(forEntityName: "Outfit", in: context) {
      let newVal = NSManagedObject(entity: entity, insertInto: context)
      newVal.setValue(name, forKey: "name")
      do {
        try context.save()
        NSLog("Outfit saved")
        
      } catch {
        NSLog("[Contacts] ERROR: Failed to save Outfit to CoreData")
      }
    }
  }
  
  func saveStyle(name: String) {
    let context = appDelegate.persistentContainer.viewContext
    if let entity = NSEntityDescription.entity(forEntityName: "Style", in: context) {
      let newVal = NSManagedObject(entity: entity, insertInto: context)
      newVal.setValue(name, forKey: "name")
      do {
        try context.save()
        NSLog("Outfit saved")
        
      } catch {
        NSLog("[Contacts] ERROR: Failed to save Style to CoreData")
      }
    }
  }
  
  func saveArticleStyle(article_id: NSManagedObjectID, style_id: NSManagedObjectID) {
    let context = appDelegate.persistentContainer.viewContext
    if let entity = NSEntityDescription.entity(forEntityName: "ArticleStyle", in: context) {
      let newVal = NSManagedObject(entity: entity, insertInto: context)
      newVal.setValue(context.object(with: article_id), forKey: "article")
      newVal.setValue(context.object(with: style_id), forKey: "style")
      do {
        try context.save()
        NSLog("Outfit saved")
        
      } catch {
        NSLog("[Contacts] ERROR: Failed to save ArticleStyle to CoreData")
      }
    }
  }
  
  func saveStyleOutfit(outfit_id: NSManagedObjectID, style_id: NSManagedObjectID) {
    let context = appDelegate.persistentContainer.viewContext
    if let entity = NSEntityDescription.entity(forEntityName: "StyleOutfit", in: context) {
      let newVal = NSManagedObject(entity: entity, insertInto: context)
      newVal.setValue(context.object(with: outfit_id), forKey: "outfit")
      newVal.setValue(context.object(with: style_id), forKey: "style")
      do {
        try context.save()
        NSLog("StyleOutfit saved")
        
      } catch {
        NSLog("[Contacts] ERROR: Failed to save StyleOutfit to CoreData")
      }
    }
  }
  
  func saveArticleOutfit(article_id: NSManagedObjectID, outfit_id: NSManagedObjectID) {
    let context = appDelegate.persistentContainer.viewContext
    if let entity = NSEntityDescription.entity(forEntityName: "ArticleOutfit", in: context) {
      let newVal = NSManagedObject(entity: entity, insertInto: context)
      newVal.setValue(context.object(with: article_id), forKey: "article")
      newVal.setValue(context.object(with: outfit_id), forKey: "outfit")
      do {
        try context.save()
        NSLog("Outfit saved")
        
      } catch {
        NSLog("[Contacts] ERROR: Failed to save ArticleOutfit to CoreData")
      }
    }
  }
}
