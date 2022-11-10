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
  let appDelegate: AppDelegate = AppDelegate()
  let image: UIImage = UIImage(named: "pusheen.png")!
  var image_data : Data {
    get {
      return image.pngData()!
    }
  }
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
  
  func updateArticles() {
    arts.removeAll()
    fetchArticles()
  }
  
  func deleteAllArticles() {
    // Initialize Fetch Request
    let fetchRequest: NSFetchRequest<Article>
    fetchRequest = Article.fetchRequest()
    
    // Get a reference to a NSManagedObjectContext
    let context = appDelegate.persistentContainer.viewContext
    context.reset()
    do {
      let objects = try context.fetch(fetchRequest)
      NSLog(String(objects.count))
      for data in objects as [NSManagedObject] {
        context.delete(data)
        //loadArticle(data: data)
        NSLog("Loaded article")
      }
      try context.save()
     
    } catch {
      print("Error")
   
    }

  }
  
  func fetchArticles() -> [Article]? {
    let fetchRequest: NSFetchRequest<Article>
    fetchRequest = Article.fetchRequest()
    
    // Get a reference to a NSManagedObjectContext
    let context = appDelegate.persistentContainer.viewContext
    do {
      let objects = try context.fetch(fetchRequest)
//      NSLog(String(objects.count))
//      NSLog((objects.first?.primary_color_name!)!)
      for data in objects {
        arts.append(data)
        NSLog("Loaded article")
      }
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
  
  func fetchArticle(article_id: UUID) -> Article? {
    let fetchRequest: NSFetchRequest<Article>
    fetchRequest = Article.fetchRequest()
    
    
    fetchRequest.predicate = NSPredicate(
      format: "article_id = %@", article_id.uuidString
    )
    
    // Get a reference to a NSManagedObjectContext
    let context = appDelegate.persistentContainer.viewContext
    do {
      let objects = try context.fetch(fetchRequest)
      return objects.first
    } catch {
      print("Error")
      return nil
    }
  }
  
//  func loadArticle(data: NSManagedObject) {
//    //let newArticle = Article()
//    let context = appDelegate.persistentContainer.viewContext
//    if let entity = NSEntityDescription.entity(forEntityName: "Article", in: context) {
//      let newArticle = NSManagedObject(entity: entity, insertInto: context)
//
//      newArticle.setValue(data.value(forKey: "image_data"), forKey: "image_data")
//      newArticle.setValue(data.value(forKey: "primary_color_name"), forKey: "primary_color_name")
//      newArticle.setValue(data.value(forKey: "primary_color_family"), forKey: "primary_color_family")
//      newArticle.setValue(data.value(forKey: "primary_color_hex"), forKey: "primary_color_hex")
//      newArticle.setValue(data.value(forKey: "secondary_color_name"), forKey: "secondary_color_name")
//      newArticle.setValue(data.value(forKey: "secondary_color_family"), forKey: "secondary_color_family")
//      newArticle.setValue(data.value(forKey: "complimentary_color_name"), forKey: "complimentary_color_name")
//      newArticle.setValue(data.value(forKey: "complimentary_color_family"), forKey: "complimentary_color_family")
//      newArticle.setValue(data.value(forKey: "complimentary_color_hex"), forKey: "complimentary_color_hex")
//      newArticle.setValue(data.value(forKey: "category"), forKey: "category")
//      newArticle.setValue(data.value(forKey: "subcategory"), forKey: "subcategory")
//
//      arts.append(newArticle as! Article)
//      NSLog("loadArticle completed")
//    }
//  }
  
  func tagArticleCategory(category: String, article: Article) {
    let context = appDelegate.persistentContainer.viewContext
    context.object(with: article.objectID).setValue(category, forKey: "category")
    do {
      try context.save()
      NSLog("saved article as category")
      
    } catch {
      NSLog("[Contacts] ERROR: Failed to save Article to CoreData")
    }
  }
  
  func tagArticleSubcategory(subcategory: String, article: Article) {
    let context = appDelegate.persistentContainer.viewContext
    context.object(with: article.objectID).setValue(subcategory, forKey: "subcategory")
    do {
      try context.save()
      NSLog("saved article as subcategory")
      
    } catch {
      NSLog("[Contacts] ERROR: Failed to save Article to CoreData")
    }
  }
  
  func saveArticle(image_data: Data, primary_color_name:String, primary_color_family: String, primary_color_hex: String, secondary_color_name: String = "", secondary_color_family: String = "",  secondary_color_hex: String = "") -> Article?{
    NSLog("starting save article")
    let context = appDelegate.persistentContainer.viewContext
    if let entity = NSEntityDescription.entity(forEntityName: "Article", in: context) {
      NSLog("created entity")
      NSLog(entity.debugDescription)
      let newVal = NSManagedObject(entity: entity, insertInto: context)
      NSLog("created newVal")
      newVal.setValue(image_data, forKey: "image_data")
      newVal.setValue(primary_color_name, forKey: "primary_color_name")
      newVal.setValue(primary_color_family, forKey: "primary_color_family")
      newVal.setValue(primary_color_hex, forKey: "primary_color_hex")
      newVal.setValue(secondary_color_name, forKey: "secondary_color_name")
      newVal.setValue(secondary_color_family, forKey: "secondary_color_family")
      newVal.setValue(secondary_color_hex, forKey: "secondary_color_hex")
      newVal.setValue(UUID(), forKey: "article_id")
//      newVal.setValue(complimentary_color_name, forKey: "complimentary_color_name")
//      newVal.setValue(complimentary_color_family, forKey: "complimentary_color_family")
//      newVal.setValue(complimentary_color_hex, forKey: "complimentary_color_hex")
//      newVal.setValue(category, forKey: "category")
//      newVal.setValue(subcategory, forKey: "subcategory")
      NSLog("Set all values for newVal")
      do {
        try context.save()
        NSLog("article saved")
        let returnVal = context.object(with:newVal.objectID) as? Article
        NSLog(returnVal.debugDescription)
        arts.append(fetchArticle(article_id: newVal.value(forKey: "article_id") as! UUID)!)//UNSAFE
//        return (arts.count-1)
//        return context.object(with:newVal.objectID) as? Article
        return arts.last
        
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
