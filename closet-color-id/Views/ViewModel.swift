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
  
  func fetchCategory(name: String) -> Category? {
    let fetchRequest: NSFetchRequest<Category>
    fetchRequest = Category.fetchRequest()

    fetchRequest.predicate = NSPredicate(
        format: "name == %@", name
    )

    // Get a reference to a NSManagedObjectContext
    let context = appDelegate.persistentContainer.viewContext

    // Perform the fetch request to get the objects
    // matching the predicate
    
    NSLog("Fetch Request:")
    NSLog(fetchRequest.description)
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

    // Perform the fetch request to get the objects
    // matching the predicate
    
    NSLog("Fetch Request:")
    NSLog(fetchRequest.description)
    do {
      let objects = try context.fetch(fetchRequest)
      return objects
    } catch {
      print("Error")
      return nil
    }
  }
  
  func fetchSubcategory(name: String) -> Subcategory? {
    let fetchRequest: NSFetchRequest<Subcategory>
    fetchRequest = Subcategory.fetchRequest()

    fetchRequest.predicate = NSPredicate(
        format: "name == %@", name
    )

    // Get a reference to a NSManagedObjectContext
    let context = appDelegate.persistentContainer.viewContext
    
    NSLog("Fetch Request:")
    NSLog(fetchRequest.description)
    do {
      let objects = try context.fetch(fetchRequest)
      return objects.first
    } catch {
      print("Error")
      return nil
    }
    
  }
  
  func tagArticleCategory(category: Category, article_id: NSManagedObjectID) {
//    newArticle.primary_color_family = ""
    let context = appDelegate.persistentContainer.viewContext
    context.object(with: article_id).setValue(category, forKey: "category")
    do {
      try context.save()
      NSLog("saved article as category")

    } catch {
      NSLog("[Contacts] ERROR: Failed to save Article to CoreData")
    }
  }
  
  func tagArticleSubcategory(subcategory: Subcategory, article_id: NSManagedObjectID) {
//    newArticle.primary_color_family = ""
    let context = appDelegate.persistentContainer.viewContext
    if let entity = NSEntityDescription.entity(forEntityName: "SubcategoryArticle", in: context) {
      let newVal = NSManagedObject(entity: entity, insertInto: context)
      newVal.setValue(context.object(with: article_id), forKey: "article")
      newVal.setValue(subcategory, forKey: "subcategory")
      NSLog("Set all values for newVal")
      do {
        try context.save()
        NSLog("Saved article subcategory")
      } catch {
        NSLog("[Contacts] ERROR: Failed to save Article to CoreData")
      }
    }
  }
  
    func saveArticle(image_data: Data, primary_color_name: String, primary_color_hex: String, primary_color_family: String, secondary_color_name: String, secondary_color_family: String, secondary_color_hex: String, complimentary_color_name: String, complimentary_color_family: String, complimentary_color_hex: String) {
//    newArticle.primary_color_family = ""
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
      newVal.setValue(complimentary_color_name, forKey: "complimentary_color_name")
      newVal.setValue(complimentary_color_family, forKey: "complimentary_color_family")
      newVal.setValue(complimentary_color_hex, forKey: "complimentary_color_hex")
      NSLog("Set all values for newVal")
      do {
        try context.save()
        context.refreshAllObjects()
        
      } catch {
        NSLog("[Contacts] ERROR: Failed to save Article to CoreData")
      }
    }
  }
  
  func fetchArticles() -> [Article?] {
    let fetchRequest: NSFetchRequest<Article>
    fetchRequest = Article.fetchRequest()

    // Get a reference to a NSManagedObjectContext
    let context = appDelegate.persistentContainer.viewContext

    // Perform the fetch request to get the objects
    // matching the predicate
    do {
      let objects = try context.fetch(fetchRequest)
      return objects
    } catch {
      NSLog("[Contacts] ERROR: Failed to save Article to CoreData")
    }
    return [nil]
  }
  
//  func deleteArticle(index: Int) {
//    let context = appDelegate.persistentContainer.viewContext
//    context.delete(articles[index])
//
//    articles.remove(at: index)
//
//    do {
//      try context.save()
//    } catch {
//      NSLog("[Contacts] ERROR: Failed to save Article to CoreData")
//    }
//  }
}

