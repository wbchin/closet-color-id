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
  var shirt: UIImage = UIImage(named: "shirt.png")!
  var pants: UIImage = UIImage(named: "jeans.png")!
  var shoes: UIImage = UIImage(named: "converse.png")!

  func createArticle() {
    let article = viewModel.saveArticle(image_data: shirt.pngData()!, primary_color_name: "beige", primary_color_family: "brown", primary_r: 111, primary_g: 78, primary_b: 55, secondary_color_name: "black", secondary_color_family: "black", secondary_r: nil, secondary_g: nil, secondary_b: nil)
    viewModel.tagArticleCategory(category: "top", article: article!)
    viewModel.tagArticleSubcategory(subcategory: "blouse", article: article!)
    let style = viewModel.fetchStyles()!.first
    viewModel.tagArticleStyle(article_id: article!.objectID, style_id: style!.objectID)
    
    let article2 = viewModel.saveArticle(image_data: pants.pngData()!, primary_color_name: "navy", primary_color_family: "blue", primary_r: 111, primary_g: 78, primary_b: 55, secondary_color_name: "black", secondary_color_family: "black", secondary_r: nil, secondary_g: nil, secondary_b: nil)
    
    viewModel.setComplimentaryColor(article: article2!, complimentary_color_family: "beige", complimentary_color_name: "skin")
    
    viewModel.tagArticleCategory(category: "bottom", article: article2!)
    viewModel.tagArticleSubcategory(subcategory: "pants", article: article2!)
    let style2 = viewModel.fetchStyles()!.first
    viewModel.tagArticleStyle(article_id: article2!.objectID, style_id: style2!.objectID)
    
    let article3 = viewModel.saveArticle(image_data: shoes.pngData()!, primary_color_name: "black", primary_color_family: "black", primary_r: 111, primary_g: 78, primary_b: 55, secondary_color_name: "white", secondary_color_family: "black", secondary_r: nil, secondary_g: nil, secondary_b: nil)
    
    viewModel.setComplimentaryColor(article: article3!, complimentary_color_family: "beige", complimentary_color_name: "skin")
    
    viewModel.tagArticleCategory(category: "footwear", article: article3!)
    viewModel.tagArticleSubcategory(subcategory: "sneaker", article: article3!)
    let style3 = viewModel.fetchStyles()!.first
    viewModel.tagArticleStyle(article_id: article3!.objectID, style_id: style3!.objectID)
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
