//
//  ViewModelTests.swift
//  closet-color-idTests
//
//  Created by Allison Cao on 11/30/22.
//

import XCTest
@testable import closet-color-id

final class ViewModelTests: XCTestCase {
  let dataPopulation = DataPopulation()
  let viewModel = ViewModel()
  override func setUp() {
      //expectation = expectation(description: "Able to perform viewmodel function")
      self.dataPopulation.createArticle()
      self.viewModel.updateArticles()
      self.dataPopulation.populateStyles()
      self.viewModel.updateStyles()
  }

  override func tearDown() {
      self.viewModel.deleteAllArticles()
      self.viewModel.deleteAllStyles()
      self.viewModel.deleteAllOutfits()
  }

  func testFetchArticles() {
    // let context = TestCoreDataStack().persistentContainer.newBackgroundContext()
    
    let articles = self.viewModel.fetchArticles()

    XCTAssertEqual(articles.first?.primary_color_name, "beige")
    self.expectation.fulfill()

    // Wait how long...
//    await waitForExpectations(timeout: expired)
  }

//    func testFetchArticles() {
//      // let context = TestCoreDataStack().persistentContainer.newBackgroundContext()
//
//      let articles = self.viewModel.fetchArticles()
//
//      XCTAssertEqual(articles.first?.primary_color_name, "beige")
//      self.expectation.fulfill()
//
//      // Wait how long...
//      await waitForExpectations(timeout: expired)
//    }

}


