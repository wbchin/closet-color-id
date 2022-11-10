////
////  TagStyleView.swift
////  closet-color-id
////
////  Created by Allison Cao on 11/8/22.
////
//
//import Foundation
//import SwiftUI
//
//struct TagStyleView: View {
//  let viewModel: ViewModel
//  var image: UIImage
//  let primary_color_name: String
//  let primary_color_family: String
//  let primary_color_hex: String
//  let secondary_color_name: String
//  let secondary_color_hex: String
//  let secondary_color_family: String
//  let complimentary_color_name: String
//  let complimentary_color_hex: String
//  let complimentary_color_family: String
//  let cat: String
//  let subcategory: String
//
//  @State var isShowingStyle = false
//
//  var styles: [Style] {
//    get {
//      return viewModel.fetchStyles()!
//    }
//  }
//  
//  var body: some View {
//    ForEach(styles) { s in
//      Button(action: {
//        let style_id = s.objectID
//        isShowingStyle = true
//      }) {
//        Text(s.name!)
//      }
//    }
//
////    if isShowingStyle != true {
////      Button(
////        action: {
////            self.viewModel.saveArticle()
////            let article = viewModel.fetchLatestArticle()
////          }) {
////            Text("Done")
////            let article = viewModel.fetchLatestArticle()
////            NavigationLink (
////              destination: ArticleView(article: article, viewModel: viewModel),
////              label:{
////                Text("Done")
////              })
////      }
//
//
//    }
//  }
//}
//
