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
          GeometryReader { geometry in
              VStack (spacing: 10) {
                  Image(uiImage: UIImage(data: article.image_data!)!).resizable().scaledToFit().cornerRadius(10)
                  Spacer()
                  Text("What type of clothing is this?")
                      .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                      .font(.system(size: 20))
                      .bold()
                      .textCase(.uppercase)
                  HStack(spacing: 20) {
                      Button("OUTERWEAR") {
                          isShowingCat = false
                          subcats = SubcategoryName.subcategoryNamesOuterwear
                          self.viewModel.tagArticleCategory(category: "outerwear", article: article)
                      }
                      .frame(width: geometry.size.width * 0.35)
                      .padding(5)
                      .background(.white)
                      .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                      .clipShape(Capsule())
                      .shadow(color: Color(red: 0.30, green: 0.11, blue: 0.00), radius: 5, x: 0, y: 0)
                      Button("TOP") {
                          isShowingCat = false
                          subcats = SubcategoryName.subcategoryNamesShirts
                          self.viewModel.tagArticleCategory(category: "top", article: article)
                      }
                      .frame(width: geometry.size.width * 0.35)
                      .padding(5)
                      .background(.white)
                      .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                      .clipShape(Capsule())
                      .shadow(color: Color(red: 0.30, green: 0.11, blue: 0.00), radius: 5, x: 0, y: 0)
                  }
                  .padding()
                  HStack(spacing: 20) {
                      Button("BOTTOM") {
                          isShowingCat = false
                          subcats = SubcategoryName.subcategoryNamesBottoms
                          self.viewModel.tagArticleCategory(category: "bottom", article: article)
                      }
                      .frame(width: geometry.size.width * 0.35)
                      .padding(5)
                      .background(.white)
                      .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                      .clipShape(Capsule())
                      .shadow(color: Color(red: 0.30, green: 0.11, blue: 0.00), radius: 5, x: 0, y: 0)
                      Button("FOOTWEAR") {
                          isShowingCat = false
                          subcats = SubcategoryName.subcategoryNamesFootwear
                          viewModel.tagArticleCategory(category: "footwear", article: article)
                      }
                      .frame(width: geometry.size.width * 0.35)
                      .padding(5)
                      .background(.white)
                      .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                      .clipShape(Capsule())
                      .shadow(color: Color(red: 0.30, green: 0.11, blue: 0.00), radius: 5, x: 0, y: 0)
                  }
                  if !isShowingCat {
                      Spacer(minLength: 5)
                      NavigationLink (
                        destination: TagSubcategoryView(viewModel: viewModel, subcats: subcats, article: article),
                        label:{
                            Text("Done").bold()
                        })
                      .frame(width: geometry.size.width * 0.35)
                      .padding(5)
                      .background(.white)
                      .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                      .clipShape(Capsule())
                      .shadow(color: Color(red: 0.30, green: 0.11, blue: 0.00), radius: 5, x: 0, y: 0)
                  }
              }
              .padding()
              .frame(width: geometry.size.width)
              .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
              .font(.system(size: 20))
              .textCase(.uppercase)
              .background(Color(red: 0.96, green: 0.94, blue: 0.91))
          }
      }.navigationBarBackButtonHidden(true)
  }
}
