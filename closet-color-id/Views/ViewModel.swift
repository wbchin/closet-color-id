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

  //@Published var contacts = [Contact]()
  
//  @Published var articles = [Article]()
  
  let appDelegate: AppDelegate = AppDelegate()
  let image: UIImage = UIImage(named: "pusheen.png")!
  var image_data : Data {
          get {
            return image.pngData()!
          }
      }

  func saveArticle() {
    // create a new Article object
//    NSLog(type(of:self.image_data))
//    let newArticle = Article(image_data: image.pngData()!, primary_color_name: "", primary_color_hex: "", primary_color_family: "", secondary_color_name: "", secondary_color_hex: "", secondary_color_family: "", complimentary_color_name: "", complimentary_color_hex: "", complimentary_color_family: "")
//    let newArticle = Article()
//    newArticle.primary_color_family = Optional("blue")
   // use api to retrieve these values
    
//    print(NSStringFromClass(article.class))
    
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
//      self.articles.append(newVal)
      
      
      
      // make sure you convert the UIImage to an Image
      // add it to the `contacts` array
    }
  }
  
//  func fetchArticles() {
//    let context = appDelegate.persistentContainer.viewContext
//    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
//    request.returnsObjectsAsFaults = false
//    do {
//      let result = try context.fetch(request)
//      for data in result as! [NSManagedObject] {
//        let newArticle = Article()
//        newArticle.primary_color_name = data.value(forKey: "primary_color_name") as? String ?? ""
//        if let uiImageNSData: NSData = data.value(forKey: "image_data") as? NSData {
//          newArticle.image_data = Image(uiImage: UIImage(data: uiImageNSData as Data, scale: 1.0)!)
//        }
//        articles.append(newArticle)
//        NSLog("[Contacts] loaded article from CoreData")
//      }
//    } catch {
//      NSLog("[Contacts] ERROR: was unable to load Articles from CoreData")
//    }
//  }
}

