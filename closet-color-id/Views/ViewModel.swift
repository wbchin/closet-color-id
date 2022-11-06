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
  
  @Published var articles = [Article]()
  let appDelegate: AppDelegate = AppDelegate()
  let image: UIImage? = nil
//  var image_data : String {
//          get {
//            return image!.pngData()!.base64EncodedString()
//          }
//      }

  func saveArticle() {
    // create a new Article object
    let newArticle = Article(imageData: "", primary_color_name: "", primary_color_hex: "", primary_color_family: "", secondary_color_name: "", secondary_color_hex: "", secondary_color_family: "", complimentary_color_name: "", complimentary_color_hex: "", complimentary_color_family: "")
   // use api to retrieve these values
    let context = appDelegate.persistentContainer.viewContext
    if let entity = NSEntityDescription.entity(forEntityName: "Article", in: context) {
      let newVal = NSManagedObject(entity: entity, insertInto: context)
      newVal.setValue("test", forKey: "image_data")
      newVal.setValue("test", forKey: "primary_color_name")
      newVal.setValue("test", forKey: "primary_color_family")
      newVal.setValue("test", forKey: "primary_color_hex")
      newVal.setValue("test", forKey: "secondary_color_name")
      newVal.setValue("test", forKey: "secondary_color_family")
      newVal.setValue("test", forKey: "secondary_color_hex")
      newVal.setValue("test", forKey: "complimentary_color_name")
      newVal.setValue("test", forKey: "complimentary_family")
      newVal.setValue("test", forKey: "complimentaryprimary_color_hex")
      do {
        try context.save()
      } catch {
        NSLog("[Contacts] ERROR: Failed to save Article to CoreData")
      }
      self.articles.append(newArticle)
      
      
      
      // make sure you convert the UIImage to an Image
      // add it to the `contacts` array
    }
  }
}

