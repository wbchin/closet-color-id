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
    Text(article.primary_color_name!)
    Text(article.primary_color_family!)
    Text(article.primary_color_hex!)
    
    if (article.category != nil) {
      Text("Category:")
      Text(article.category!.name!)
    }
    
    Spacer()
    
    if (article.subcategoryArticles != nil) {
      Text("Subcategory:")
      
      // need this line to unpack subcategoryArticle type
      let array = article.subcategoryArticles?.allObjects as! [SubcategoryArticle]
      ForEach(array) { subcategoryArticle in
        Text(subcategoryArticle.subcategory!.name!)
        }
    }
    
    Button(action: {
      let top_category = viewModel.fetchCategory(name: "top")
      self.viewModel.tagArticleCategory(category_id: top_category!.objectID, article_id: article.objectID)
    }) {
      Text("Mark as top")
    }
    
    Button(action: {
      let blouse_subcat = viewModel.fetchSubcategory(name: "blouse")
      self.viewModel.tagArticleSubcategory(subcategory_id: blouse_subcat!.objectID, article_id: article.objectID)
    }) {
      Text("Mark as blouse")
    }
    
    
    
    }
}

//struct ArticleView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArticleView()
//    }
//}
