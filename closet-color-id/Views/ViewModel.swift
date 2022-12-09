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
    //  for testing without deploying:
    //  let image: UIImage = UIImage(named: "pusheen.png")!
    //  var image_data : Data {
    //    get {
    //      return image.pngData()!
    //    }
    //  }
    
    @Published var arts = [Article]()
    @Published var styles = [Style]()
    @Published var article: Article?
    @Published var outfit: Outfit?
    @Published var image: UIImage?
    
    // MARK: - Article Methods
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
    
    func saveArticle(image_data: Data, primary_color_name: String, primary_color_family: String, primary_r: Int, primary_g: Int, primary_b: Int, secondary_color_name: String?, secondary_color_family: String?,  secondary_r: Int?, secondary_g: Int?, secondary_b: Int?) -> Article?{
        let context = appDelegate.persistentContainer.viewContext
        if let entity = NSEntityDescription.entity(forEntityName: "Article", in: context) {
            let newVal = NSManagedObject(entity: entity, insertInto: context)
            newVal.setValue(image_data, forKey: "image_data")
            newVal.setValue(primary_color_name, forKey: "primary_color_name")
            // set the color primary family
            let primary_color = rgbToHue(r: (CGFloat)(Float(primary_r)/255.0), g: (CGFloat)(Float(primary_g)/255.0), b: (CGFloat)(Float(primary_b)/255.0))
            let primary_family = setColorFamily(hue: primary_color.0, saturation: primary_color.1, brightness: primary_color.2)
            newVal.setValue(primary_family, forKey: "primary_color_family")
            newVal.setValue(primary_r, forKey: "primary_r")
            newVal.setValue(primary_g, forKey: "primary_g")
            newVal.setValue(primary_b, forKey: "primary_b")
            newVal.setValue(secondary_color_name, forKey: "secondary_color_name")
            // set the color secondary family only if there is a secondary color
            if (secondary_r != nil && secondary_b != nil && secondary_g != nil) {
                let secondary_color = rgbToHue(r: (CGFloat)(Float(secondary_r!)/255.0), g: (CGFloat)(Float(secondary_g!)/255.0), b: (CGFloat)(Float(secondary_b!)/255.0))
                let secondary_family = setColorFamily(hue: secondary_color.0, saturation: secondary_color.1, brightness: secondary_color.2)
                newVal.setValue(secondary_family, forKey: "secondary_color_family")
            } else {
                newVal.setValue(secondary_color_family, forKey: "secondary_color_family")
            }
            newVal.setValue(secondary_r, forKey: "secondary_r")
            newVal.setValue(secondary_g, forKey: "secondary_g")
            newVal.setValue(secondary_b, forKey: "secondary_b")
            newVal.setValue(UUID(), forKey: "article_id")
            do {
                try context.save()
                let returnVal = context.object(with:newVal.objectID) as? Article
                arts.append(returnVal!)
                //        arts.append(fetchArticle(article_id: newVal.value(forKey: "article_id") as! UUID)!)
                self.article = returnVal
                return returnVal
                
            } catch {
                NSLog("[Contacts] ERROR: Failed to save Article to CoreData")
            }
        }
        return nil
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
    
    func tagArticleSubcategory(subcategory: String, article: Article) {
        let context = appDelegate.persistentContainer.viewContext
        context.object(with: article.objectID).setValue(subcategory, forKey: "subcategory")
        do {
            try context.save()
        } catch {
            NSLog("[Contacts] ERROR: Failed to save Article to CoreData")
        }
    }
    
    func retrieveOutfitsForArticle(article: Article) -> [Outfit]? {
        var out = [Outfit]()
        //let context = appDelegate.persistentContainer.viewContext
        let articleOutfits = article.articleOufits
        
        for case let articleOutfit as ArticleOutfit in articleOutfits!.allObjects {
            out.append(articleOutfit.outfit!)
        }
        
        return out
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
            for data in objects as [NSManagedObject] {
                context.delete(data)
            }
            try context.save()
            
        } catch {
            print("Error")
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
    
    func deleteUnstyledArticles(completion: @escaping((Bool) -> ())) {
        let myGroup = DispatchGroup()
        myGroup.enter()
        let context = appDelegate.persistentContainer.viewContext
        
        for art in self.arts {
            if art.articleStyles!.count == 0 {
                context.delete(context.object(with: art.objectID))
            }
        }
        
        do {
            try context.save()
            self.updateArticles()
            myGroup.leave()
            myGroup.notify(queue: DispatchQueue.global(qos: .background)) {
                completion(true)
            }
        } catch {
            print("issue with deleting unstyled articles")
        }
    }
    
    func deleteUntaggedArticles(completion: @escaping((Bool) -> ())) {
        let myGroup = DispatchGroup()
        myGroup.enter()
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
            ]
        )
        do {
            let objects = try context.fetch(fetchRequest)
            for object in objects as [NSManagedObject] {
                context.delete(object)
            }
            try context.save()
            self.updateArticles()
            myGroup.leave()
            myGroup.notify(queue: DispatchQueue.global(qos: .background)) {
                completion(true)
            }
        } catch {
            print("Error")
        }
    }
    
    // MARK: - Outfit Methods
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
    
    func renameOutfit(outfit: Outfit, name: String) {
        let context = appDelegate.persistentContainer.viewContext
        if let entity = NSEntityDescription.entity(forEntityName: "Outfit", in: context) {
            let newVal = NSManagedObject(entity: entity, insertInto: context)
            newVal.setValue(name, forKey: "name")
            do {
                try context.save()
                self.outfit = newVal as! Outfit
            } catch {
                NSLog("[Contacts] ERROR: Failed to save ArticleStyle to CoreData")
            }
        }
    }
    
    func saveOutfit(name: String, completion: @escaping((Outfit) -> ())) {
        let myGroup = DispatchGroup()
        myGroup.enter()
        let context = appDelegate.persistentContainer.viewContext
        context.mergePolicy = NSMergePolicy(merge: NSMergePolicyType.mergeByPropertyObjectTrumpMergePolicyType)
        
        if let entity = NSEntityDescription.entity(forEntityName: "Outfit", in: context) {
            let newVal = NSManagedObject(entity: entity, insertInto: context)
            newVal.setValue(name, forKey: "name")
            do {
                try context.save()
                self.outfit = newVal as! Outfit
                NSLog("Outfit saved")
                // return newVal as? Outfit
                myGroup.leave()
                myGroup.notify(queue: DispatchQueue.global(qos: .background)) {
                    completion(self.outfit!)
                }
                
            } catch {
                NSLog("ERROR: Failed to save Outfit to CoreData")
                NSLog(error.localizedDescription)
            }
        }
    }
    
    func retrieveArticlesForOutfit(outfit: Outfit) -> [Article]? {
        var out = [Article]()
        //let context = appDelegate.persistentContainer.viewContext
        let articleOutfits = outfit.articleOutfits
        
        for case let articleOutfit as ArticleOutfit in articleOutfits!.allObjects {
            out.append(articleOutfit.article!)
        }
        
        return out
    }
    
    @objc func generateOutfit(style: String, name: String) {
        //let context = appDelegate.persistentContainer.viewContext
        var outfitCreated = false
        let style = fetchStyle(name: style)!
        print("style: ")
        print(style)
        var count = 0
        while (!outfitCreated && count <= 500) {
            count = count + 1
            
            let tops = fetchStyleCats(style: style, category: "top")!
            let bottoms = fetchStyleCats(style: style, category: "bottom")!
            let footwear = fetchStyleCats(style: style, category: "footwear")!
            
            // randomly select which top to match with
            let res_top = tops.randomElement()
            if res_top == nil {
                print("not enough items to create outfit")
                return
            }
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
                continue
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
            
            self.saveOutfit(name: name, completion: {out in })
            
            // save ArticleOutfits
            if self.outfit != nil {
                self.saveArticleOutfit(article_id: res_top!.objectID, outfit_id: self.outfit!.objectID)
                self.saveArticleOutfit(article_id: res_bottom!.objectID, outfit_id: self.outfit!.objectID)
                self.saveArticleOutfit(article_id: res_footwear!.objectID, outfit_id: self.outfit!.objectID)
                print("done generating outfit")
                outfitCreated = true
            }
        }
    }
    
    func deleteAllOutfits() {
        // Initialize Fetch Request
        let fetchRequest: NSFetchRequest<Outfit>
        fetchRequest = Outfit.fetchRequest()
        
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
    
    // MARK: - Style Methods
    func fetchStyles() {
        let fetchRequest: NSFetchRequest<Style>
        fetchRequest = Style.fetchRequest()
        
        // Get a reference to a NSManagedObjectContext
        let context = appDelegate.persistentContainer.viewContext
        do {
            let objects = try context.fetch(fetchRequest)
            for data in objects {
                styles.append(data)
            }
        } catch {
            print("Error")
        }
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
    
    func updateStyles() {
        styles.removeAll()
        fetchStyles()
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
    
    // MARK: - ArticleStyle Methods
    func fetchStyleArts(style: Style) -> [Article]? {
        var out = [Article]()
        let articleStyles = style.articleStyles
        
        for case let articleStyle as ArticleStyle in articleStyles!.allObjects {
            out.append(articleStyle.article!)
        }
        
        return out
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
    
    // MARK: - ArticleOutfit Methods
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
    
    // MARK: - Complimentary Article and Color Generation
    func findBlackOrWhiteArticle(article: Article) -> Article? {
        let fetchRequest: NSFetchRequest<Article>
        fetchRequest = Article.fetchRequest()
        let white_color_predicate = NSPredicate(
            format: "primary_color_family = %@", "white"
        )
        let black_color_predicate = NSPredicate(
            format: "primary_color_family = %@", "black"
        )
        let category_predicate = NSPredicate(
            format: "category != %@", article.category!
        )
        
        if (article.secondary_color_family != nil) {
            let white_color_predicate_secondary = NSPredicate(
                format: "secondary_color_family = %@", "white"
            )
            let black_color_predicate_secondary = NSPredicate(
                format: "secondary_color_family = %@", "black"
            )
            
            fetchRequest.predicate = NSCompoundPredicate(
                andPredicateWithSubpredicates: [
                    NSCompoundPredicate(orPredicateWithSubpredicates: [
                        white_color_predicate,
                        black_color_predicate,
                        white_color_predicate_secondary,
                        black_color_predicate_secondary,
                    ]),
                    category_predicate
                ]
            )
        } else {
            fetchRequest.predicate = NSCompoundPredicate(
                andPredicateWithSubpredicates: [
                    NSCompoundPredicate(orPredicateWithSubpredicates: [
                        white_color_predicate,
                        black_color_predicate,
                    ]),
                    category_predicate
                ]
            )
        }
        let context = appDelegate.persistentContainer.viewContext
        do {
            let objects = try context.fetch(fetchRequest)
            return objects.first
        } catch {
            print("Error")
            return nil
        }
    }
        
        func findComplimentaryArticle(article: Article) -> Article? {
            let fetchRequest: NSFetchRequest<Article>
            fetchRequest = Article.fetchRequest()
            let color_predicate1 = NSPredicate(
                format: "complimentary_color_family = %@", article.complimentary_color_family!
            )
            let color_predicate2 = NSPredicate(
                format: "complimentary_color_family = %@", article.primary_color_family!
            )
            let color_predicate3 = NSPredicate(
                format: "complimentary_color_family = %@", article.secondary_color_family!
            )
            let color_predicate4 = NSPredicate(
                format: "primary_color_family = %@", article.complimentary_color_family!
            )
            
            let category_predicate = NSPredicate(
                format: "category != %@", article.category!
            )
            
            if (article.secondary_color_family != nil) {
                let color_predicate5 = NSPredicate(
                    format: "secondary_color_family = %@", article.complimentary_color_family!
                )
                
                fetchRequest.predicate = NSCompoundPredicate(
                    andPredicateWithSubpredicates: [
                        NSCompoundPredicate(orPredicateWithSubpredicates: [
                            color_predicate1,
                            color_predicate2,
                            color_predicate3,
                            color_predicate4,
                            color_predicate5
                        ]),
                        category_predicate
                    ]
                )
            } else {
                fetchRequest.predicate = NSCompoundPredicate(
                    andPredicateWithSubpredicates: [
                        NSCompoundPredicate(orPredicateWithSubpredicates: [
                            color_predicate1,
                            color_predicate2,
                            color_predicate3,
                            color_predicate4
                        ]),
                        category_predicate
                    ]
                )
            }
            
            let context = appDelegate.persistentContainer.viewContext
            do {
                let objects = try context.fetch(fetchRequest)
                // return black or white for no complimentary colors
                if objects.first == nil {
                    return findBlackOrWhiteArticle(article: article)
                }
                return objects.first
            } catch {
                print("Error")
                return nil
            }
        }
        
        func setColorFamily(hue: Int, saturation: CGFloat, brightness: CGFloat) -> String{
            var family = "other"
            if (0 <= hue && hue < 30 || 330 <= hue && hue <= 360) {
                family = "red"
            }
            if (30 <= hue && hue < 60) {
                family = "orange"
            }
            if (60 <= hue && hue < 90) {
                family = "yellow"
            }
            if (90 <= hue && hue < 180) {
                family = "green"
            }
            if (180 <= hue && hue < 270) {
                family = "blue"
            }
            if (270 <= hue && hue < 300) {
                family = "violet"
            }
            if (300 <= hue && hue < 330) {
                family = "magenta"
            }
            if (0.70 < brightness && brightness <= 1.0 && 0 <= saturation && saturation <= 0.20) {
                family = "white"
            }
            if (0 <= brightness && brightness <= 0.30 && 0 <= saturation && saturation <= 0.30) {
                family = "black"
            }
            return family
        }
        
        func setComplimentaryColor(article: Article, complimentary_color_family: String, complimentary_color_name: String, complimentary_r: Int, complimentary_g: Int, complimentary_b: Int) {
            let context = appDelegate.persistentContainer.viewContext
            context.object(with: article.objectID).setValue(complimentary_color_family, forKey: "complimentary_color_family")
            context.object(with: article.objectID).setValue(complimentary_color_name, forKey: "complimentary_color_name")
            context.object(with: article.objectID).setValue(complimentary_r, forKey: "complimentary_r")
            context.object(with: article.objectID).setValue(complimentary_g, forKey: "complimentary_g")
            context.object(with: article.objectID).setValue(complimentary_b, forKey: "complimentary_b")
            do {
                try context.save()
            } catch {
                NSLog("[Contacts] ERROR: Failed to complimentary color saved")
            }
        }
        
        func rgbToHue(r:CGFloat,g:CGFloat,b:CGFloat) -> (Int, CGFloat, CGFloat) {
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
            return (Int(hue), saturation, brightness)
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
            let articleStyles = style.articleStyles
            
            for case let articleStyle as ArticleStyle in articleStyles!.allObjects {
                if (articleStyle.article!.category! == category) {
                    out.append(articleStyle.article!)
                }
            }
            
            return out
        }
        
        enum ColorFamily {
            case red
            case orange
            case yellow
            case green
            case blue
            case violet
            case magenta
            case white
            case black
            
            
            var rgb: (r: Double, g: Double, b: Double) {
                switch self {
                case .red:
                    return (1.0, 0.12, 0.12)
                case .orange:
                    return (0.93, 0.47, 0.05)
                case .yellow:
                    return (1.0, 0.84, 0.0)
                case .green:
                    return (0.14, 1.0, 0.13)
                case .blue:
                    return (0.0, 0.28, 1.0)
                case .violet:
                    return (0.51, 0.08, 0.94)
                case .magenta:
                    return (0.96, 0.04, 0.96)
                case .white:
                    return (1.0, 1.0, 1.0)
                case .black:
                    return (0.0, 0.0, 0.0)
                }
            }
        }
        func rgbColorFamily (color: String) -> (Double, Double, Double) {
            if color == "red" {
                return (1.0, 0.12, 0.12)
            }
            if color == "orange" {
                return (0.93, 0.47, 0.05)
            }
            if color == "yellow" {
                return (1.0, 0.84, 0.0)
            }
            if color == "green" {
                return (0.14, 1.0, 0.13)
            }
            if color == "blue" {
                return (0.0, 0.28, 1.0)
            }
            if color == "violet" {
                return (0.51, 0.08, 0.94)
            }
            if color == "magenta" {
                return (0.96, 0.04, 0.96)
            }
            if color == "white" {
                return (1.0, 1.0, 1.0)
            }
            if color == "black" {
                return (0.0, 0.0, 0.0)
            }
            return (0.0, 0.0, 0.0)
        }
}
