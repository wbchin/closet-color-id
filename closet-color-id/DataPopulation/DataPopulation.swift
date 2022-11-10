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
  var shirt: UIImage = UIImage(named: "pusheen.png")!

  func createArticle() {
    viewModel.saveArticle(image_data: shirt.pngData()!, primary_color_name: "pink", primary_color_family: "red", primary_color_hex: "#ffffff", secondary_color_name: "black", secondary_color_family: "black", secondary_color_hex: "#000000")
  }

  // ["Professional", "Casual", "Night Out", "Athletic"]
  func populateStyles() {
    let context = appDelegate.persistentContainer.viewContext
    if let entity = NSEntityDescription.entity(forEntityName: "Style", in: context) {
      NSLog("created entity")
      NSLog(entity.debugDescription)

      let prof = NSManagedObject(entity: entity, insertInto: context)
      prof.setValue("professional", forKey: "name")
      let casual = NSManagedObject(entity: entity, insertInto: context)
      casual.setValue("casual", forKey: "name")
      let night = NSManagedObject(entity: entity, insertInto: context)
      night.setValue("night", forKey: "name")
      let athletic = NSManagedObject(entity: entity, insertInto: context)
      athletic.setValue("athletic", forKey: "name")

      do {
        try context.save()
        NSLog("styles populated")
      } catch {
        NSLog("[Contacts] ERROR: Failed to save Styles to CoreData")
      }
    }
  }
}
