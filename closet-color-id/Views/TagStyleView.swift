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
      ForEach(StyleName.allCats, id: \.self) { s in
      Button(action: {
//        viewModel.saveArticleStyle(article_id: <#T##NSManagedObjectID#>, style_id: <#T##NSManagedObjectID#>)
        isShowingStyle = false
      }) {
        Text(s)
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
