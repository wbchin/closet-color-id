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
  var timer: Timer?

  @State var generateOutfitStyle: Style = Style()
  @State var genrateOutfitName: String = ""
  

  @Published var arts = [Article]()
  @Published var styles = [Style]()
  
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
  
  func updateStyles() {
    styles.removeAll()
    fetchStyles()
  }
  
  func deleteAllArticleStyles() {
    // Initialize Fetch Request
    let fetchRequest: NSFetchRequest<ArticleStyle>
    fetchRequest = ArticleStyle.fetchRequest()
    
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
  
  func deleteAllStyles() {
    // Initialize Fetch Request
    let fetchRequest: NSFetchRequest<Style>
    fetchRequest = Style.fetchRequest()
    
    // Get a reference to a NSManagedObjectContext
    let context = appDelegate.persistentContainer.viewContext
    context.reset()
    do {
      let objects = try context.fetch(fetchRequest)
      for data in objects as [NSManagedObject] {
        context.delete(data)
        //loadArticle(data: data)
        NSLog("Deleted all the styles")
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
      for data in objects {
        styles.append(data)
        NSLog("Loaded style")
      }
      return objects
    } catch {
      print("Error")
      return nil
    }
  }
    
//    func fetchSubcatCatArts(category: String, subcategories: [String]) -> [[Article]] {
//        var out = [Article]()
//        let context = appDelegate.persistentContainer.viewContext
//        //context.object(with: article.objectID).setValue(category, forKey: "category")
//        for subcategory in subcategories {
//            for article in self.arts {
//                if context.object(with: article.objectID).value(forKey: "category") as! String == category{
//                    out.append(self.fetchSubcatArts(subcategory: subcategory))
//                }
//            }
//        }
//        return out
//    }
    
    func fetchSubcatArts(subcategory: String) -> [Article] {
        var out = [Article]()
        let context = appDelegate.persistentContainer.viewContext
        //context.object(with: article.objectID).setValue(category, forKey: "category")
        for article in self.arts {
            if context.object(with: article.objectID).value(forKey: "subcategory") as! String == subcategory{
                out.append(article)
            }
        }
        return out
    }
    
    func fetchCatArts(category: String) -> [Article] {
        var out = [Article]()
        let context = appDelegate.persistentContainer.viewContext
        //context.object(with: article.objectID).setValue(category, forKey: "category")
        for article in self.arts {
          NSLog(article.category!)
            if context.object(with: article.objectID).value(forKey: "category") as! String == category{
                out.append(article)
            }
        }
        return out
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
  
  func findComplimentaryArticle(article: Article) -> Article? {
    let fetchRequest: NSFetchRequest<Article>
    fetchRequest = Article.fetchRequest()
    fetchRequest.predicate = NSPredicate(
      format: "complimentary_color_family = %@", article.complimentary_color_family!
    )
    let color_predicate = NSPredicate(
        format: "complimentary_color_family = %@", article.complimentary_color_family!
    )
    let category_predicate = NSPredicate(
        format: "category != %@", article.category!
    )
    
    fetchRequest.predicate = NSCompoundPredicate(
        andPredicateWithSubpredicates: [
          color_predicate,
          category_predicate
        ]
    )
    let context = appDelegate.persistentContainer.viewContext
    do {
      let objects = try context.fetch(fetchRequest)
      return objects.first
    } catch {
      print("Error")
      return nil
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
  
  func setColorFamily(hue: Int) -> String{
    if (0 <= hue && hue < 55) {
      return "red"
    }
    if (55 <= hue && hue < 110) {
      return "orange"
    }
    if (110 <= hue && hue < 165) {
      return "yellow"
    }
    if (165 <= hue && hue < 220) {
      return "green"
    }
    if (220 <= hue && hue < 275) {
      return "blue"
    }
    if (275 <= hue && hue < 330) {
      return "indigo"
    }
    if (330 <= hue && hue < 360) {
      return "violet"
    }
    return ""
  }
  
  func setComplimentaryColor(article: Article, complimentary_color_family: String, complimentary_color_name: String) {
    let context = appDelegate.persistentContainer.viewContext
    context.object(with: article.objectID).setValue(complimentary_color_family, forKey: "complimentary_color_family")
    context.object(with: article.objectID).setValue(complimentary_color_name, forKey: "complimentary_color_name")
    do {
      try context.save()
      NSLog("complimentary color saved")
    } catch {
      NSLog("[Contacts] ERROR: Failed to complimentary color saved")
    }
  }
  
  func saveArticle(image_data: Data, primary_color_name: String, primary_color_family: String, primary_r: Int, primary_g: Int, primary_b: Int, secondary_color_name: String?, secondary_color_family: String?,  secondary_r: Int?, secondary_g: Int?, secondary_b: Int?) -> Article?{
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
      newVal.setValue(primary_r, forKey: "primary_r")
      newVal.setValue(primary_g, forKey: "primary_g")
      newVal.setValue(primary_b, forKey: "primary_b")
      newVal.setValue(secondary_color_name, forKey: "secondary_color_name")
      newVal.setValue(secondary_color_family, forKey: "secondary_color_family")
      newVal.setValue(secondary_r, forKey: "secondary_r")
      newVal.setValue(secondary_g, forKey: "secondary_g")
      newVal.setValue(secondary_b, forKey: "secondary_b")
      newVal.setValue(UUID(), forKey: "article_id")
      NSLog("Set all values for newVal")
      do {
        try context.save()
        NSLog("article saved")
        let returnVal = context.object(with:newVal.objectID) as? Article
        NSLog(returnVal.debugDescription)
        arts.append(fetchArticle(article_id: newVal.value(forKey: "article_id") as! UUID)!)//UNSAFE
//        return (arts.count-1)
//        return context.object(with:newVal.objectID) as? Article
        return returnVal
        
      } catch {
        NSLog("[Contacts] ERROR: Failed to save Article to CoreData")
      }
    }
    return nil
  }
  
  func saveOutfit(name: String) -> Outfit?{
    let context = appDelegate.persistentContainer.viewContext
    if let entity = NSEntityDescription.entity(forEntityName: "Outfit", in: context) {
      let newVal = NSManagedObject(entity: entity, insertInto: context)
      newVal.setValue(name, forKey: "name")
      do {
        try context.save()
        NSLog("Outfit saved")
        return newVal as? Outfit
        
      } catch {
        NSLog("[Contacts] ERROR: Failed to save Outfit to CoreData")
      }
    }
    return nil
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
  
  func tagArticleStyle(article_id: NSManagedObjectID, style_id: NSManagedObjectID) {
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
  
  func fetchStyleCats(style: Style, category: String) -> [Article]? {
    print("Style: ----> ")
    print(style)
    
    var out = [Article]()
    
    let context = appDelegate.persistentContainer.viewContext
    print("first article Style:")
    print(style.articleStyles?.allObjects.first as! ArticleStyle)
    let articleStyles = style.articleStyles
    
    for case let articleStyle as ArticleStyle in articleStyles!.allObjects {
      print("article style style")
      print(articleStyle.style)
      print("article style article")
      print(articleStyle.article)
      if (articleStyle.article!.category! == category) {
        out.append(articleStyle.article!)
      }
    }
    
    return out
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
  
  func retrieveOutfitsForArticle(article: Article) -> [Outfit]? {
    var out = [Outfit]()
    let context = appDelegate.persistentContainer.viewContext
    let articleOutfits = article.articleOufits
    
    for case let articleOutfit as ArticleOutfit in articleOutfits!.allObjects {
      out.append(articleOutfit.outfit!)
    }
    
    return out
  }
  
  @objc func generateOutfit(sender: Timer) {
    let context = appDelegate.persistentContainer.viewContext
    var outfitCreated = false
    let userInfo = sender.userInfo as! [String]
    print("making user info")
    let style = self.fetchStyle(name: "professional")!
    let name = userInfo[1]
    while !outfitCreated {
      //let context = appDelegate.persistentContainer.viewContext
      //let articleStyles = self.generateOutfitStyle.articleStyles
      
      let tops = fetchStyleCats(style: style, category: "top")!
      let bottoms = fetchStyleCats(style: style, category: "bottom")!
      let footwear = fetchStyleCats(style: style, category: "footwear")!
      
      // randomly select which top to match with
      
      let res_top = tops.randomElement()
      var res_bottom: Article? = nil
      var res_footwear: Article? = nil
      
      for bottom in bottoms {
        if (bottom.complimentary_color_family == res_top!.primary_color_family || bottom.primary_color_family == res_top!.complimentary_color_family ||
            bottom.secondary_color_family == res_top!.complimentary_color_family ||
            bottom.complimentary_color_family == res_top!.secondary_color_family) {
          res_bottom = bottom
        }
      }
      
      for foot in footwear {
        if (foot.complimentary_color_family == res_top!.primary_color_family || foot.primary_color_family == res_top!.complimentary_color_family ||
            foot.secondary_color_family == res_top!.complimentary_color_family ||
            foot.complimentary_color_family == res_top!.secondary_color_family) {
          res_footwear = foot
        }
      }
      
      if (res_bottom == nil || res_footwear == nil) {
        print("cannot find articles to generate outfit")
        return
      }
      
      // check for duplication
      let res_top_outfits = retrieveOutfitsForArticle(article: res_top!)
      let res_bottom_outfits = retrieveOutfitsForArticle(article: res_bottom!)
      let res_footwear_outfits = retrieveOutfitsForArticle(article: res_footwear!)
      
      let top_bottom = res_top_outfits!.filter{ res_bottom_outfits!.contains($0) }
      let top_bottom_footwear = top_bottom.filter{ res_footwear_outfits!.contains($0) }
      
      if top_bottom_footwear.count != 0 {
        print("this outfit is a duplicate")
        continue
      }
      
      // save outfit
      let outfit = self.saveOutfit(name: name)
      
      // save ArticleOutfits
      self.saveArticleOutfit(article_id: res_top!.objectID, outfit_id: outfit!.objectID)
      self.saveArticleOutfit(article_id: res_bottom!.objectID, outfit_id: outfit!.objectID)
      self.saveArticleOutfit(article_id: res_footwear!.objectID, outfit_id: outfit!.objectID)
      
      NSLog("done generating outfit")
      outfitCreated = true
      sender.invalidate()
    }
    
  }
  
  func isDuplicateOutfit(outfit: Outfit) {
    let context = appDelegate.persistentContainer.viewContext
    
    let fetchRequest: NSFetchRequest<Outfit>
    fetchRequest = Outfit.fetchRequest()
    
    let cat_predicate = NSPredicate(
        format: "articleStyles == nil"
    )
    let subcat_predicate = NSPredicate(
        format: "subcategory = nil"
    )
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
  
  func deleteUnstyledArticles() {
    NSLog("Deleting unstyled articles")
    let articles = fetchArticles()!
    
    for article in articles {
      print(article.debugDescription)
      if article.articleStyles == nil {
        print("article style is nil")
      }
    }

  }
  
  func deleteUntaggedArticles() {
    NSLog("Deleting untagged articles")
    let context = appDelegate.persistentContainer.viewContext
    
    let fetchRequest: NSFetchRequest<Article>
    fetchRequest = Article.fetchRequest()
    
    let cat_predicate = NSPredicate(
        format: "category = nil"
    )
    let subcat_predicate = NSPredicate(
        format: "subcategory = nil"
    )
    
    fetchRequest.predicate = NSCompoundPredicate(
        orPredicateWithSubpredicates: [
          cat_predicate,
          subcat_predicate
          //style_predicate
        ]
    )
    do {
      let objects = try context.fetch(fetchRequest)
      for object in objects as [NSManagedObject] {
        context.delete(object)
      }
      try context.save()
    } catch {
      print("Error")
    }
  }
}
