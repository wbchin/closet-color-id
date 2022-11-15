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
  @Published var styles = [Style]()
    @Published var article: Article?
  
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
      for data in objects as [NSManagedObject] {
        context.delete(data)
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
      for data in objects as [NSManagedObject] {
        context.delete(data)
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
      for data in objects {
        arts.append(data)
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
      }
      return objects
    } catch {
      print("Error")
      return nil
    }
  }
    func fetchSubcatArts(subcategory: String) -> [Article] {
        var out = [Article]()
        let context = appDelegate.persistentContainer.viewContext
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
        for article in self.arts {
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
    } catch {
      NSLog("[Contacts] ERROR: Failed to complimentary color saved")
    }
  }
  
  func rgbToHue(r:CGFloat,g:CGFloat,b:CGFloat) -> Int {
    let minV:CGFloat = CGFloat(min(r, g, b))
    let maxV:CGFloat = CGFloat(max(r, g, b))
    let delta:CGFloat = maxV - minV
    var hue:CGFloat = 0
    if delta != 0 {
      if r == maxV {
         hue = (g - b) / delta
      }
      else if g == maxV {
         hue = 2 + (b - r) / delta
      }
      else {
         hue = 4 + (r - g) / delta
      }
      hue *= 60
      if hue < 0 {
         hue += 360
      }
    }
    
    let saturation = maxV == 0 ? 0 : (delta / maxV)
    let brightness = maxV
    return Int(hue)
  }

  
  func saveArticle(image_data: Data, primary_color_name: String, primary_color_family: String, primary_r: Int, primary_g: Int, primary_b: Int, secondary_color_name: String?, secondary_color_family: String?,  secondary_r: Int?, secondary_g: Int?, secondary_b: Int?) -> Article?{
    let context = appDelegate.persistentContainer.viewContext
    if let entity = NSEntityDescription.entity(forEntityName: "Article", in: context) {
      let newVal = NSManagedObject(entity: entity, insertInto: context)
      newVal.setValue(image_data, forKey: "image_data")
      newVal.setValue(primary_color_name, forKey: "primary_color_name")
      // set the color primary family by hue
      let hue = rgbToHue(r: (CGFloat)(Float(primary_r)/255.0), g: (CGFloat)(Float(primary_g)/255.0), b: (CGFloat)(Float(primary_b)/255.0))
      let family = setColorFamily(hue: hue)
      newVal.setValue(family, forKey: "primary_color_family")
      newVal.setValue(primary_r, forKey: "primary_r")
      newVal.setValue(primary_g, forKey: "primary_g")
      newVal.setValue(primary_b, forKey: "primary_b")
      newVal.setValue(secondary_color_name, forKey: "secondary_color_name")
      newVal.setValue(secondary_color_family, forKey: "secondary_color_family")
      newVal.setValue(secondary_r, forKey: "secondary_r")
      newVal.setValue(secondary_g, forKey: "secondary_g")
      newVal.setValue(secondary_b, forKey: "secondary_b")
      newVal.setValue(UUID(), forKey: "article_id")
      do {
        try context.save()
        let returnVal = context.object(with:newVal.objectID) as? Article
        arts.append(fetchArticle(article_id: newVal.value(forKey: "article_id") as! UUID)!)//UNSAFE
          self.article = returnVal
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
      } catch {
        NSLog("[Contacts] ERROR: Failed to save StyleOutfit to CoreData")
      }
    }
  }
  
  func fetchStyleCats(style: Style, category: String) -> [Article]? {
    
    var out = [Article]()
    
    let context = appDelegate.persistentContainer.viewContext
    let articleStyles = style.articleStyles
    
    for case let articleStyle as ArticleStyle in articleStyles!.allObjects {
      if (articleStyle.article!.category! == category) {
        out.append(articleStyle.article!)
      }
    }
    
    return out
  }
  
  func generateOutfit(style: Style, name: String) {
    let context = appDelegate.persistentContainer.viewContext
    let articleStyles = style.articleStyles
    
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
    
    // save outfit
    let outfit = self.saveOutfit(name: name)
    
    // save ArticleOutfits
    self.saveArticleOutfit(article_id: res_top!.objectID, outfit_id: outfit!.objectID)
    self.saveArticleOutfit(article_id: res_bottom!.objectID, outfit_id: outfit!.objectID)
    self.saveArticleOutfit(article_id: res_footwear!.objectID, outfit_id: outfit!.objectID)
  }
  
  func saveArticleOutfit(article_id: NSManagedObjectID, outfit_id: NSManagedObjectID) {
    let context = appDelegate.persistentContainer.viewContext
    if let entity = NSEntityDescription.entity(forEntityName: "ArticleOutfit", in: context) {
      let newVal = NSManagedObject(entity: entity, insertInto: context)
      newVal.setValue(context.object(with: article_id), forKey: "article")
      newVal.setValue(context.object(with: outfit_id), forKey: "outfit")
      do {
        try context.save()
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
    } catch {
      NSLog("[Contacts] ERROR: Failed to delete article from CoreData")
    }
  }
  
  func deleteUnstyledArticles() {
    let articles = fetchArticles()!
    
    for article in articles {
      if article.articleStyles == nil {
        print("article style is nil")
      }
    }

  }
  
  func deleteUntaggedArticles() {
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
