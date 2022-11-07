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
  //  @Published var articles = [Article]()
//  @FetchRequest(entity: Article.entity(), sortDescriptors: [])
//  var articles: FetchedResults<Article>
  @Published var articles = [Article]()
  let appDelegate: AppDelegate = AppDelegate()
  let image: UIImage = UIImage(named: "pusheen.png")!
  var image_data : Data {
    get {
      return image.pngData()!
    }
  }
  
  func saveArticle() {
//    let newArticle = Article()
//    newArticle.primary_color_family = ""
    let context = appDelegate.persistentContainer.viewContext
    if let entity = NSEntityDescription.entity(forEntityName: "Article", in: context) {
      NSLog("created entity")
      NSLog(entity.debugDescription)
      let newVal = NSManagedObject(entity: entity, insertInto: context)
      NSLog("created newVal")
      newVal.setValue(self.image_data, forKey: "image_data")
      newVal.setValue("blue test", forKey: "primary_color_name")
      newVal.setValue("test", forKey: "primary_color_family")
      newVal.setValue("test", forKey: "primary_color_hex")
      newVal.setValue("test", forKey: "secondary_color_name")
      newVal.setValue("test", forKey: "secondary_color_family")
      newVal.setValue("test", forKey: "secondary_color_hex")
      newVal.setValue("test", forKey: "complimentary_color_name")
      newVal.setValue("test", forKey: "complimentary_color_family")
      newVal.setValue("test", forKey: "complimentary_color_hex")
      NSLog("Set all values for newVal")
      do {
        try context.save()
        
      } catch {
        NSLog("[Contacts] ERROR: Failed to save Article to CoreData")
      }
    }
  }
  
//  func fetchArticles() -> FetchedResults<Article> {
//    @FetchRequest(entity: Article.entity(), sortDescriptors: [])
//    //var articles: FetchedResults<Article>
//    return articles
//  }
  
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

