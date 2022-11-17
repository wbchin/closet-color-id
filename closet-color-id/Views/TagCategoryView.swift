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
              HStack {
                  Button("OUTERWEAR") {
                      isShowingCat = false
                      subcats = SubcategoryName.subcategoryNamesBottoms
                      viewModel.tagArticleCategory(category: "outerwear", article: article)
                  }
                  .padding(4)
                  .background(.white)
                  .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                  .border(Color(red: 0.30, green: 0.11, blue: 0.00), width: 2)
                  .font(.system(size: 20))
                  
                  Button("TOP") {
                      isShowingCat = false
                      subcats = SubcategoryName.subcategoryNamesShirts
                      viewModel.tagArticleCategory(category: "top", article: article)
                  }
                  .padding(4)
                  .background(.white)
                  .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                  .border(Color(red: 0.30, green: 0.11, blue: 0.00), width: 2)
                  .font(.system(size: 20))
              }
              HStack {
                  Button("BOTTOM") {
                      isShowingCat = false
                      subcats = SubcategoryName.subcategoryNamesBottoms
                      viewModel.tagArticleCategory(category: "bottom", article: article)
                  }
                  .padding(4)
                  .background(.white)
                  .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                  .border(Color(red: 0.30, green: 0.11, blue: 0.00), width: 2)
                  .font(.system(size: 20))
                  
                  Button("FOOTWEAR") {
                      isShowingCat = false
                      subcats = SubcategoryName.subcategoryNamesBottoms
                      viewModel.tagArticleCategory(category: "footwear", article: article)
                  }
                  .padding(4)
                  .background(.white)
                  .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                  .border(Color(red: 0.30, green: 0.11, blue: 0.00), width: 2)
                  .font(.system(size: 20))
              }
              if !isShowingCat {
                  NavigationLink (
                    destination: TagSubcategoryView(viewModel: viewModel, subcats: subcats, article: article),
                    label:{
                        Text("Done").frame(maxHeight: 50, alignment: .bottom).font(.system(size: 30))
                    })
              }
              
          }
      }.navigationBarBackButtonHidden(true)
    
  }
}
