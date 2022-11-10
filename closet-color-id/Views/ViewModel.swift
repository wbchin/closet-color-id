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
//  var image_data : Data {
//    get {
//      return image.pngData()!
//    }
//  }
    var image_data = UIImage(named:"pusheen.png")?.pngData()
    @Published var arts = [Article]()
  
  func fetchLatestArticle() -> Article? {
    let fetchRequest: NSFetchRequest<Article>
    fetchRequest = Article.fetchRequest()
    
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
    fetchRequest.fetchLimit = 1
    
    let context = appDelegate.persistentContainer.viewContext
    do {
      let objects = try context.fetch(fetchRequest)
      return objects.first
    } catch {
      print("Error")
      return nil
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
  
    func fetchArticles() {
      let context = appDelegate.persistentContainer.viewContext
      let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
      request.returnsObjectsAsFaults = false
      do {
        let result = try context.fetch(request)
        for data in result as! [NSManagedObject] {
          loadArticle(data: data)
          NSLog("[Article] loaded")
        }
      } catch {
        NSLog("[Contacts] ERROR: was unable to load Contacts from CoreData")
      }
    }
    
    func loadArticle(data: NSManagedObject) {
      let newArticle = Article()
        newArticle.image_data = data.value(forKey: "image_data") as? Data
        newArticle.primary_color_name = data.value(forKey: "primary_color_name") as? String
        newArticle.primary_color_family = data.value(forKey: "primary_color_family") as? String
        newArticle.primary_color_hex = data.value(forKey: "primary_color_hex") as? String
        newArticle.secondary_color_name = data.value(forKey: "secondary_color_name") as? String
        newArticle.secondary_color_family = data.value(forKey: "secondary_color_family") as? String
        newArticle.secondary_color_hex = data.value(forKey: "secondary_color_hex") as? String
        newArticle.complimentary_color_name = data.value(forKey: "complimentary_color_name") as? String
        newArticle.complimentary_color_family = data.value(forKey: "complimentary_color_family") as? String
        newArticle.complimentary_color_hex = data.value(forKey: "complimentary_color_hex") as? String
        newArticle.category = data.value(forKey: "category") as? String
        newArticle.subcategory = data.value(forKey: "subcategory") as? String
      arts.append(newArticle)
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
  
    func saveArticle() -> Article? {
    let context = appDelegate.persistentContainer.viewContext
    if let entity = NSEntityDescription.entity(forEntityName: "Article", in: context) {
      NSLog("created entity")
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
          arts.append((context.object(with:newVal.objectID) as? Article)!)//UNSAFE
          return context.object(with:newVal.objectID) as? Article
          
        
      } catch {
        NSLog("[Contacts] ERROR: Failed to save Article to CoreData")
      }
        
    }
        return nil
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
  
  func deleteArticle(article_id: NSManagedObjectID) {
    let context = appDelegate.persistentContainer.viewContext
    context.delete(context.object(with: article_id))
    do {
      try context.save()
      NSLog("Article deleted")
      
    } catch {
      NSLog("[Contacts] ERROR: Failed to delete article from CoreData")
    }
  }
}
