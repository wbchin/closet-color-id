//
//  ArticleView.swift
//  closet-color-id
//
//  Created by Waverly Chin on 11/2/22.
//

import SwiftUI
import CoreData

struct ArticleView: View {
  var article: Article
  let viewModel: ViewModel
  
  var body: some View {
    
//    Text(article.primary_color_name!)
//    Text(article.primary_color_family!)
//    Text(article.primary_color_hex!)
    
    Text(article.primary_color_name!)
    
//    if (article.category != nil) {
//      Text(article.category!)
//    }
//    
//    if (article.subcategory != nil) {
//      Text(article.subcategory!)
//    }
    
    Spacer()
    }
}

//struct ArticleView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArticleView()
//    }
//}
