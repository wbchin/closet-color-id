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
    var shirt: UIImage? = UIImage(named: "sweater.png") ?? nil
    var pants: UIImage? = UIImage(named: "pants.png") ?? nil
    var shoes: UIImage? = UIImage(named: "hypebeast_shoes.png") ?? nil
    var jacket: UIImage? = UIImage(named: "jacket.png") ?? nil

  func createArticle() {
      let style = self.fetchStyle(name: "casual")
      if shirt != nil{
          let article = viewModel.saveArticle(image_data: shirt!.pngData()!, primary_color_name: "baby blue", primary_color_family: "blue", primary_r: 199, primary_g: 218, primary_b: 255, secondary_color_name: "white", secondary_color_family: "white", secondary_r: nil, secondary_g: nil, secondary_b: nil)
        viewModel.tagArticleCategory(category: "top", article: article!)
        viewModel.tagArticleSubcategory(subcategory: "blouse", article: article!)
        viewModel.tagArticleStyle(article_id: article!.objectID, style_id: style!.objectID)
        viewModel.setComplimentaryColor(article: article!, complimentary_color_family: "black", complimentary_color_name: "skin", complimentary_r: 0, complimentary_g: 0, complimentary_b: 0)
      } else {
          print("Error: article 1 image to data failed")
      }
      
      if pants != nil {
          let article2 = viewModel.saveArticle(image_data: pants!.pngData()!, primary_color_name: "ebony black", primary_color_family: "black", primary_r: 0, primary_g: 0, primary_b: 0, secondary_color_name: nil, secondary_color_family: nil, secondary_r: nil, secondary_g: nil, secondary_b: nil)
          
          viewModel.setComplimentaryColor(article: article2!, complimentary_color_family: "white", complimentary_color_name: "skin", complimentary_r: 0, complimentary_g: 0, complimentary_b: 0)
          viewModel.tagArticleCategory(category: "bottom", article: article2!)
          viewModel.tagArticleSubcategory(subcategory: "pants", article: article2!)
          viewModel.tagArticleStyle(article_id: article2!.objectID, style_id: style!.objectID)
      } else {
          print("Error: article 2 image to data failed")
      }
      
      if shoes != nil {
          let article3 = viewModel.saveArticle(image_data: shoes!.pngData()!, primary_color_name: "wedding white", primary_color_family: "white", primary_r: 255, primary_g: 255, primary_b: 255, secondary_color_name: "fire hydrant red", secondary_color_family: "red", secondary_r: 196, secondary_g: 41, secondary_b: 41)
          
          viewModel.setComplimentaryColor(article: article3!, complimentary_color_family: "white", complimentary_color_name: "skin", complimentary_r: 0, complimentary_g: 0, complimentary_b: 0)
          
          viewModel.tagArticleCategory(category: "footwear", article: article3!)
          viewModel.tagArticleSubcategory(subcategory: "sneaker", article: article3!)
          viewModel.tagArticleStyle(article_id: article3!.objectID, style_id: style!.objectID)
      } else {
          print("Error: article 3 image to data failed")
      }
      if jacket != nil {
          let article3 = viewModel.saveArticle(image_data: jacket!.pngData()!, primary_color_name: "ebony black", primary_color_family: "black", primary_r: 0, primary_g: 0, primary_b: 0, secondary_color_name: nil, secondary_color_family: nil, secondary_r: nil, secondary_g: nil, secondary_b: nil)
          
          viewModel.setComplimentaryColor(article: article3!, complimentary_color_family: "black", complimentary_color_name: "wedding white", complimentary_r: 0, complimentary_g: 0, complimentary_b: 0)
          
          viewModel.tagArticleCategory(category: "outerwear", article: article3!)
          viewModel.tagArticleSubcategory(subcategory: "windbreaker", article: article3!)
          viewModel.tagArticleStyle(article_id: article3!.objectID, style_id: style!.objectID)
      } else {
          print("Error: article 4 image to data failed")
      }
    

  }
  
  func fetchStyle(name: String) -> Style?{
    let context = appDelegate.persistentContainer.viewContext
    let fetchRequest: NSFetchRequest<Style>
     fetchRequest = Style.fetchRequest()
     fetchRequest.predicate = NSPredicate(format: "name == %@", name)
 
     do {
       let objects = try context.fetch(fetchRequest)
       return objects.first
     } catch {
       print("Error")
       return nil
     }
  }

  // ["Professional", "Casual", "Night Out", "Athletic"]
    func populateStyles() {
        let context = appDelegate.persistentContainer.viewContext
        if let entity = NSEntityDescription.entity(forEntityName: "Style", in: context) {
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
            } catch {
                NSLog("[Contacts] ERROR: Failed to save Styles to CoreData")
            }
        }
    }
}
