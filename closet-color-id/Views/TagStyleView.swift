import Foundation
import SwiftUI

struct TagStyleView: View {
  let viewModel: ViewModel
//  @State private var capturedImage: UIImage? = UIImage(named:"shirt.png")
  var article: Article
  @State var isShowingStyle = true
//
//  var styles: [Style] {
//    get {
//      return viewModel.fetchStyles()!
//    }
//  }
//
  var body: some View {
    ForEach(self.viewModel.styles) { style in
      Button(action: {
        viewModel.tagArticleStyle(article_id: article.objectID, style_id: style.objectID)
        isShowingStyle = false
      }) {
        Text(style.name!)
      }
    }
    

    if !isShowingStyle {
//        let article = self.viewModel.saveArticle()
        NavigationLink (
            destination: ArticleView(article: article, viewModel: viewModel),
          label:{
            Text("Done")
          })//UNSAFE
//      Button(
//        action: {
            
            
//            let article = viewModel.fetchLatestArticle()
            
//          }) {
//            Text("Done")
//            let article = viewModel.fetchLatestArticle()
//            NavigationLink (
//              destination: ArticleView(article: article, viewModel: viewModel),
//              label:{
//                Text("Done")
//              })
//      }

    }
  }
}
