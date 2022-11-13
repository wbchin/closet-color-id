import Foundation
import SwiftUI
            
struct TagCategoryView: View {
  let viewModel: ViewModel
  let article: Article
  @State private var cat = ""
    @State private var subcats = [""]
  @State var isShowingCat = true
    
  
  var body: some View {
      NavigationView{
          VStack {
            // insert image here
              Image(uiImage: UIImage(data: article.image_data!)!).resizable().scaledToFit().padding().rotationEffect(.degrees(90))
            Button(action: {
                isShowingCat = false
                cat = "top"
                subcats = SubcategoryName.subcategoryNamesShirts
                viewModel.tagArticleCategory(category: "top", article: article)
            }) {
              Text("Top").frame(maxHeight: .infinity, alignment: .bottom).font(.system(size: 36))
            }
            Button(action: {
                isShowingCat = false
              subcats = SubcategoryName.subcategoryNamesBottoms
                viewModel.tagArticleCategory(category: "bottom", article: article)
            }) {
              Text("Bottom").font(.system(size: 36))
            }
            Button(action: {
                isShowingCat = false
                subcats = SubcategoryName.subcategoryNamesFootwear
              viewModel.tagArticleCategory(category: "top", article: article)
            }) {
              Text("Footwear").font(.system(size: 36))
            }
            
            if !isShowingCat {
              NavigationLink (
                destination: TagSubcategoryView(viewModel: viewModel, subcats: subcats, article: article),
                label:{
                  Text("Done").frame(maxHeight: 50, alignment: .bottom).font(.system(size: 36))
                })
            }
          }
      }.navigationBarBackButtonHidden(true)
    
  }
}
