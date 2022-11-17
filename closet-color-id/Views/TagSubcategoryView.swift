import Foundation
import SwiftUI

struct TagSubcategoryView: View {
  let viewModel: ViewModel
    let subcats: [String]
  let style = ""
  let article: Article
  @State var isShowingSubcat = true
  
  var body: some View {
      NavigationView{
          VStack{
              Image(uiImage: UIImage(data: article.image_data!)!).resizable().scaledToFit().padding().rotationEffect(.degrees(90))
              ForEach(self.subcats, id: \.self) { sub in
                  Button(sub.uppercased()) {
                      isShowingSubcat = false
                      viewModel.tagArticleSubcategory(subcategory: sub, article: article)
                  }
                  .padding(4)
                  .background(.white)
                  .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                  .border(Color(red: 0.30, green: 0.11, blue: 0.00), width: 2)
                  .font(.system(size: 20))
              }
              if !isShowingSubcat {
                NavigationLink (
                  destination: TagStyleView(viewModel: viewModel, article: article),
                  label:{
                    Text("Done").font(.system(size: 30))
                  })
          }
          
          }
      }.navigationBarBackButtonHidden(true)
    
    
    
  }
}
