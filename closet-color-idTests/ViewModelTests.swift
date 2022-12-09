//
//  ViewModelTests.swift
//  closet-color-idTests
//
//  Created by Allison Cao on 11/30/22.
//

import XCTest
@testable import closet_color_id
import CoreData

final class ViewModelTests: XCTestCase {
    let dataPopulation = DataPopulation()
    let viewModel = ViewModel()
    let appDelegate = AppDelegate()
    override func setUp() {
        //expectation = expectation(description: "Able to perform viewmodel function")
        self.viewModel.deleteAllArticles()
        self.viewModel.deleteAllStyles()
        self.viewModel.deleteAllOutfits()
        
        
        self.dataPopulation.populateStyles()
        self.viewModel.updateStyles()
        self.dataPopulation.createArticle()
        self.viewModel.updateArticles()
        
    }

    override func tearDown() {
        self.viewModel.deleteAllArticles()
        self.viewModel.deleteAllStyles()
        self.viewModel.deleteAllOutfits()
    }

    func testFetchArticles() {
        let articles = self.viewModel.fetchArticles()

        XCTAssertEqual(articles![0].primary_color_name!, "beige")
        XCTAssertEqual(articles![1].primary_color_name!, "navy")
        XCTAssertEqual(articles![2].primary_color_name!, "black")
    }
    
    func testFetchCatArts() {
      let tops = self.viewModel.fetchCatArts(category: "top")
      let bottoms = self.viewModel.fetchCatArts(category: "bottom")
        let footwear = self.viewModel.fetchCatArts(category: "footwear")
        XCTAssertEqual(tops[0].primary_color_name!, "beige")
        XCTAssertEqual(bottoms[0].primary_color_name!, "navy")
        XCTAssertEqual(footwear[0].primary_color_name!, "black")
    }
    
    func testFetchSubcatArts() {
        let sneakers = self.viewModel.fetchSubcatArts(subcategory: "sneaker")
        XCTAssertEqual(sneakers[0].primary_color_name!, "black")
    }
    
//    func testFetchArticle() {
//        let article = self.viewModel.fetchArticle
//    }
    
    func testSaveArticle() {
        let image_data = UIImage(named: "pusheen.png")
        self.viewModel.saveArticle(image_data: image_data!.pngData()!, primary_color_name: "beige", primary_color_family: "white", primary_r: 100, primary_g: 100, primary_b: 100, secondary_color_name: "beige", secondary_color_family: "white", secondary_r: 100, secondary_g: 100, secondary_b: 100)
        
        // test that the article has been updated
        self.viewModel.updateArticles()
        XCTAssertEqual(self.viewModel.article!.primary_r, 100)
        self.viewModel.deleteArticle(article_id: self.viewModel.article!.objectID)
    }
    
    func testTagArticleCategory() {
        let image_data = UIImage(named: "pusheen.png")
        self.viewModel.saveArticle(image_data: image_data!.pngData()!, primary_color_name: "beige", primary_color_family: "white", primary_r: 100, primary_g: 100, primary_b: 100, secondary_color_name: "beige", secondary_color_family: "white", secondary_r: 100, secondary_g: 100, secondary_b: 100)
        self.viewModel.updateArticles()
        
        self.viewModel.tagArticleCategory(category: "top", article: self.viewModel.article!)
        
        // test that the article category has been updated
        self.viewModel.updateArticles()
        XCTAssertEqual(self.viewModel.article!.category, "top")
        self.viewModel.deleteArticle(article_id: self.viewModel.article!.objectID)
    }
    
    func testTagArticleSubcategory() {
        let image_data = UIImage(named: "pusheen.png")
        self.viewModel.saveArticle(image_data: image_data!.pngData()!, primary_color_name: "beige", primary_color_family: "white", primary_r: 100, primary_g: 100, primary_b: 100, secondary_color_name: "beige", secondary_color_family: "white", secondary_r: 100, secondary_g: 100, secondary_b: 100)
        self.viewModel.updateArticles()
        
        self.viewModel.tagArticleSubcategory(subcategory: "Long sleeve", article: self.viewModel.article!)
        
        // test that the article subcategory has been updated
        self.viewModel.updateArticles()
        XCTAssertEqual(self.viewModel.article!.subcategory, "Long sleeve")
        self.viewModel.deleteArticle(article_id: self.viewModel.article!.objectID)
    }
    
//    func testRetrieveOutfitsForArticle() { // come back and cmplete this
//        let outfits = self.viewModel.retrieveOutfitsForArticle(article: self.viewModel.article!)
//        
//        XCTAssertEqual(self.viewModel.article!.subcategory, "Long sleeve")
//    }
    
    // update articles is tested in save article
    
    func testDeleteArticle() {
        let image_data = UIImage(named: "pusheen.png")
        self.viewModel.saveArticle(image_data: image_data!.pngData()!, primary_color_name: "beige", primary_color_family: "white", primary_r: 100, primary_g: 100, primary_b: 100, secondary_color_name: "beige", secondary_color_family: "white", secondary_r: 100, secondary_g: 100, secondary_b: 100)
        self.viewModel.updateArticles()
        self.viewModel.deleteArticle(article_id: self.viewModel.article!.objectID)
        
        self.viewModel.updateArticles()
        XCTAssertEqual(self.viewModel.arts.count, 3)
    }
    
    func testDeleteUnstyledArticles() {
        // save an unstyled article
        let image_data = UIImage(named: "pusheen.png")
        self.viewModel.saveArticle(image_data: image_data!.pngData()!, primary_color_name: "beige", primary_color_family: "white", primary_r: 100, primary_g: 100, primary_b: 100, secondary_color_name: "beige", secondary_color_family: "white", secondary_r: 100, secondary_g: 100, secondary_b: 100)
        self.viewModel.deleteUnstyledArticles(completion: {success in})
        
        // arts should only have three articles now
        self.viewModel.updateArticles()
        XCTAssertEqual(self.viewModel.arts.count, 3)
    }
    
    func testDeleteUntaggedArticles() {
        // save an untagged article
        let image_data = UIImage(named: "pusheen.png")
        self.viewModel.saveArticle(image_data: image_data!.pngData()!, primary_color_name: "beige", primary_color_family: "white", primary_r: 100, primary_g: 100, primary_b: 100, secondary_color_name: "beige", secondary_color_family: "white", secondary_r: 100, secondary_g: 100, secondary_b: 100)
        self.viewModel.deleteUntaggedArticles(completion: {success in})
        
        // arts should only have three articles now
        self.viewModel.updateArticles()
        XCTAssertEqual(self.viewModel.arts.count, 3)
    }
    
    func testDeleteAllArticles() {
        self.viewModel.deleteAllArticles()
        self.viewModel.updateArticles()
        
        XCTAssertEqual(self.viewModel.arts.count, 0)
    }
    
    // MARK: - Test Style Methods
    
    func testSaveStyle() {
        self.viewModel.saveStyle(name: "testStyle")
        
        XCTAssertEqual(self.viewModel.fetchStyle(name: "testStyle")!.name, "testStyle")
    }
    
    func testDeleteAllStyles() {
        self.viewModel.deleteAllStyles()
        self.viewModel.updateStyles()
        
        XCTAssertEqual(self.viewModel.styles.count, 0)
    }
    
    // MARK: - Test ArticleStyle Methods
    
    func testFetchStyleArts() {
        let style = self.viewModel.fetchStyle(name: "professional")
        let articles = self.viewModel.fetchStyleArts(style: style!)
        
        XCTAssertEqual(articles!.count, 3)
        XCTAssertEqual(articles!.first?.primary_r, 111)
    }
    
    func testDeleteAllArticleStyles() {
        self.viewModel.deleteAllArticleStyles()
        
        let fetchRequest: NSFetchRequest<ArticleStyle>
        fetchRequest = ArticleStyle.fetchRequest()
        
        // Get a reference to a NSManagedObjectContext
        let context = self.appDelegate.persistentContainer.viewContext
        do {
          let objects = try context.fetch(fetchRequest)
            XCTAssertEqual(objects.count, 0)
        } catch {
          print("Error")
        }
    }
    
    func testTagArticleStyle() {
        // save an article
        let image_data = UIImage(named: "pusheen.png")
        self.viewModel.saveArticle(image_data: image_data!.pngData()!, primary_color_name: "beige", primary_color_family: "white", primary_r: 100, primary_g: 100, primary_b: 100, secondary_color_name: "beige", secondary_color_family: "white", secondary_r: 100, secondary_g: 100, secondary_b: 100)
        let style = self.viewModel.fetchStyle(name: "casual")
        self.viewModel.tagArticleStyle(article_id: self.viewModel.article!.objectID, style_id: style!.objectID)
        
        var styles = [Style]()
        let articleStyles = self.viewModel.article?.articleStyles
        
        for case let articleStyle as ArticleStyle in articleStyles!.allObjects {
            styles.append(articleStyle.style!)
        }
     
        XCTAssertEqual(styles.first!.name, "casual")
        
        // delete article
        self.viewModel.deleteArticle(article_id: self.viewModel.article!.objectID)
    }
    
    // MARK: - Test ArticleOutfit Methods
    func testRenameOutfit() {
        self.viewModel.saveOutfit(name: "testOutfit", completion: {success in})
        self.viewModel.renameOutfit(outfit: self.viewModel.outfit!, name: "renamedTestOutfit")
        
        XCTAssertEqual(self.viewModel.outfit!.name, "renamedTestOutfit")
    }
    
    func testSaveArticleOutfit() {
        // save an article
        let image_data = UIImage(named: "pusheen.png")
        self.viewModel.saveArticle(image_data: image_data!.pngData()!, primary_color_name: "beige", primary_color_family: "white", primary_r: 100, primary_g: 100, primary_b: 100, secondary_color_name: "beige", secondary_color_family: "white", secondary_r: 100, secondary_g: 100, secondary_b: 100)
        
        // save an outfit
        self.viewModel.saveOutfit(name: "casual", completion: {success in})
        
        self.viewModel.saveArticleOutfit(article_id: self.viewModel.article!.objectID, outfit_id: self.viewModel.outfit!.objectID)
        
        let articles = self.viewModel.retrieveArticlesForOutfit(outfit: self.viewModel.outfit!)
        
        XCTAssertEqual(articles?.first, self.viewModel.article)
    }
    
    
    // MARK: - Test Outfit Methods
    func testSaveOutfits() {
        self.viewModel.saveOutfit(name: "casual", completion: {success in})
        
        let outfits = self.viewModel.fetchOutfits()
        XCTAssertEqual(outfits!.count, 1)
        //self.viewModel.delet
    }
    
//    func testFetchOutfits() {
//        let outfits = self.viewModel.fetchOutfits()
//
//        XCTAssertEqual(outfits!.count, 1)
//    }
    
//    func testSaveStyleOutfit() {
//        self.viewModel.saveOutfit(name: "testOutfit", completion: {success in})
//
//        self.viewModel.saveStyleOutfit(outfit_id: self.viewModel.outfit!.objectID, style_id: self.viewModel.fetchStyle(name: "professional")!)
//
//        XCTAssertEqual(self.viewModel.fetchOutfits(), 1)
//    }
    
//    func testFindComplimentaryArticle() {
//        let image_data = UIImage(named: "pusheen.png")
//        self.viewModel.saveArticle(image_data: image_data!.pngData()!, primary_color_name: "beige", primary_color_family: "white", primary_r: 100, primary_g: 100, primary_b: 100, secondary_color_name: "beige", secondary_color_family: "white", secondary_r: 100, secondary_g: 100, secondary_b: 100)
//        let style = self.viewModel.fetchStyle(name: "casual")
//        self.viewModel.tagArticleStyle(article_id: self.viewModel.article!.objectID, style_id: style!.objectID)
//        self.viewModel.tagArticleCategory(category: "top", article: self.viewModel.article!)
//        self.viewModel.tagArticleSubcategory(subcategory: "long sleeve", article: self.viewModel.article!)
//        let comp_art = self.viewModel.findComplimentaryArticle(article: self.viewModel.article!)
//
//        XCTAssertEqual(comp_art, nil)
//        XCTAssertNil(comp_art)
//    }
    
    func testGenerateOutfit() {
        self.viewModel.generateOutfit(style: "professional", name: "interview outfit")
        XCTAssertEqual(self.viewModel.outfit!.name, "interview outfit")
        let articles = self.viewModel.retrieveArticlesForOutfit(outfit: self.viewModel.outfit!)
        let outfits = self.viewModel.retrieveOutfitsForArticle(article: articles!.first!)
        
        // test styleoutfit save
        
        XCTAssertEqual(self.viewModel.fetchOutfits()!.count, 1)
        XCTAssertEqual(articles!.count, 3)
        XCTAssertEqual(outfits!.count, 1)
        XCTAssertEqual(outfits!.first!.name, "interview outfit")
        
        // ensuret that duplicate cannot be made
        self.viewModel.generateOutfit(style: "professional", name: "interview outfit")
        
        // ensure that outfit with no articles cannot be creted
        self.viewModel.generateOutfit(style: "casual", name: "school outfit")
        
        // ensure that outfit with no footwear articles cannot be creted
        let image_data = UIImage(named: "pusheen.png")
        self.viewModel.saveArticle(image_data: image_data!.pngData()!, primary_color_name: "beige", primary_color_family: "white", primary_r: 100, primary_g: 100, primary_b: 100, secondary_color_name: "beige", secondary_color_family: "white", secondary_r: 100, secondary_g: 100, secondary_b: 100)
        self.viewModel.updateArticles()
        self.viewModel.tagArticleCategory(category: "top", article: self.viewModel.article!)
        let casual = self.viewModel.fetchStyle(name: "casual")
        self.viewModel.tagArticleStyle(article_id: self.viewModel.article!.objectID, style_id: casual!.objectID)
        
        self.viewModel.saveArticle(image_data: image_data!.pngData()!, primary_color_name: "beige", primary_color_family: "brown", primary_r: 100, primary_g: 100, primary_b: 100, secondary_color_name: "beige", secondary_color_family: "white", secondary_r: 100, secondary_g: 100, secondary_b: 100)
        self.viewModel.updateArticles()
        self.viewModel.tagArticleCategory(category: "bottom", article: self.viewModel.article!)
        self.viewModel.tagArticleStyle(article_id: self.viewModel.article!.objectID, style_id: casual!.objectID)
        
        self.viewModel.generateOutfit(style: "casual", name: "school outfit")
        
        // ensure that nil botttom works
        self.viewModel.saveArticle(image_data: image_data!.pngData()!, primary_color_name: "beige", primary_color_family: "white", primary_r: 100, primary_g: 100, primary_b: 100, secondary_color_name: "beige", secondary_color_family: "white", secondary_r: 100, secondary_g: 100, secondary_b: 100)
        self.viewModel.updateArticles()
        self.viewModel.tagArticleCategory(category: "top", article: self.viewModel.article!)
        let athletic = self.viewModel.fetchStyle(name: "athletic")
        self.viewModel.tagArticleStyle(article_id: self.viewModel.article!.objectID, style_id: athletic!.objectID)

        self.viewModel.saveArticle(image_data: image_data!.pngData()!, primary_color_name: "beige", primary_color_family: "brown", primary_r: 100, primary_g: 100, primary_b: 100, secondary_color_name: "beige", secondary_color_family: "white", secondary_r: 100, secondary_g: 100, secondary_b: 100)
        self.viewModel.updateArticles()
        self.viewModel.tagArticleCategory(category: "footwear", article: self.viewModel.article!)
        self.viewModel.tagArticleStyle(article_id: self.viewModel.article!.objectID, style_id: athletic!.objectID)
        
        self.viewModel.generateOutfit(style: "athletic", name: "gym outfit")
        
        XCTAssertEqual(self.viewModel.fetchOutfits()!.count, 1) //count has not been increased
    }
    
    func testDeleteAllOutfits() {
        self.viewModel.deleteAllOutfits()
        
        XCTAssertEqual(self.viewModel.fetchOutfits()!.count, 0)
    }
    

    // MARK: - Test Complimentary Article Generation Methods
    
    func testFetchStyleCats() {
        let prof = self.viewModel.fetchStyle(name: "professional")
        let arts = self.viewModel.fetchStyleCats(style: prof!, category: "top")
        
        XCTAssertEqual(arts?.first!.primary_color_name, "beige")
        XCTAssertEqual(arts!.count, 1)
    }
    
    func testFindBlackOrWhiteArticle() {
        let image_data = UIImage(named: "pusheen.png")
        self.viewModel.saveArticle(image_data: image_data!.pngData()!, primary_color_name: "beige", primary_color_family: "white", primary_r: 100, primary_g: 100, primary_b: 100, secondary_color_name: "beige", secondary_color_family: "white", secondary_r: 100, secondary_g: 100, secondary_b: 100)
        self.viewModel.updateArticles()
        self.viewModel.tagArticleCategory(category: "top", article: self.viewModel.article!)
        let comp_article = self.viewModel.findBlackOrWhiteArticle(article: self.viewModel.article!)
    }
    
    func testRgbToHue() {
        let hsb = self.viewModel.rgbToHue(r: 100.0/255.0, g: 100.0/255.0, b: 200.0/255.0)
        
        XCTAssertEqual(hsb.0, 240)
        XCTAssertEqual(hsb.1, 0.50)
        XCTAssertEqual(hsb.2, 0.7843137254901961)
    }
    
    func testSaveComplimentaryArticle() {
        // save an image
        let image_data = UIImage(named: "pusheen.png")
        self.viewModel.saveArticle(image_data: image_data!.pngData()!, primary_color_name: "beige", primary_color_family: "white", primary_r: 100, primary_g: 100, primary_b: 100, secondary_color_name: "beige", secondary_color_family: "white", secondary_r: 100, secondary_g: 100, secondary_b: 100)
        self.viewModel.updateArticles()
        
        let complimentary_color_hsb = self.viewModel.rgbToHue(r: 33, g: 100, b: 100)
        let complimentary_color_family = self.viewModel.setColorFamily(hue: complimentary_color_hsb.0, saturation: complimentary_color_hsb.1, brightness: complimentary_color_hsb.2)
        
        self.viewModel.setComplimentaryColor(article: self.viewModel.article!, complimentary_color_family: complimentary_color_family, complimentary_color_name: "ocean blue", complimentary_r: 33, complimentary_g: 100, complimentary_b: 100)
        
        XCTAssertEqual(self.viewModel.article?.complimentary_color_family, "cyan")
        XCTAssertEqual(self.viewModel.article?.complimentary_r, 33)
        XCTAssertEqual(self.viewModel.article?.complimentary_g, 100)
        XCTAssertEqual(self.viewModel.article?.complimentary_g, 100)
        self.viewModel.deleteArticle(article_id: self.viewModel.article!.objectID)
    }
    
    func testSaveStyleOutfit() {
        self.viewModel.saveOutfit(name: "testOutfit", completion: {success in})
        let testOutfit = self.viewModel.outfit
        let casual = self.viewModel.fetchStyle(name: "casual")
        self.viewModel.saveStyleOutfit(outfit_id: testOutfit!.objectID, style_id: casual!.objectID)
        
        for case let style as Style in testOutfit!.style!.allObjects {
            XCTAssertEqual(style, style)
        }
        //XCTAssertEqual((testOutfit!.style as! [Style]).first, style)
    }
    
    func testFindComplimentaryArticle() {
        let article = self.viewModel.findComplimentaryArticle(article: self.viewModel.arts.first!)
        
        
        XCTAssertEqual(article?.complimentary_color_family, self.viewModel.arts.first!.primary_color_family)
        
        let article2 = self.viewModel.findComplimentaryArticle(article: self.viewModel.arts[1])
        
        XCTAssertEqual(article2?.secondary_color_family, "black")
    }
    
    
    
    

}


