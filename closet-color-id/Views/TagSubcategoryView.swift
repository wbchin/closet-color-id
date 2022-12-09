import Foundation
import SwiftUI

struct TagSubcategoryView: View {
  let viewModel: ViewModel
    let subcats: [String]
  let style = ""
  let article: Article
  @State var isShowingSubcat = true
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
  var body: some View {
      NavigationView{
          GeometryReader { geometry in
              VStack {
                  Image(uiImage: UIImage(data: article.image_data!)!).resizable().scaledToFit().cornerRadius(10)
                  LazyVGrid(columns: columns) {
                      ForEach(self.subcats, id: \.self) { sub in
                          Button(sub.uppercased()) {
                              isShowingSubcat = false
                              self.viewModel.tagArticleSubcategory(subcategory: sub, article: article)
                          }
                          .frame(width: geometry.size.width * 0.4)
                          .padding(5)
                          .background(.white)
                          .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                          .clipShape(Capsule())
                          .shadow(color: Color(red: 0.30, green: 0.11, blue: 0.00), radius: 5, x: 0, y: 0)
                      }
                  }
                  if !isShowingSubcat {
                      NavigationLink (
                        destination: TagStyleView(viewModel: viewModel, article: article),
                        label:{
                            Text("Done").font(.system(size: 30))
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
