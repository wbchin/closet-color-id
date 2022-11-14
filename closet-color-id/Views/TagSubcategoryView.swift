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
                Button(action: {
                  isShowingSubcat = false
                    viewModel.tagArticleSubcategory(subcategory: sub, article: article)
                }) {
                    Text(sub.lowercased())
                }.frame(maxHeight: .infinity, alignment: .bottom).font(.system(size: 36))
              }
              if !isShowingSubcat {
                NavigationLink (
                  destination: TagStyleView(viewModel: viewModel, article: article),
                  label:{
                    Text("Done").frame(maxHeight: .infinity, alignment: .bottom).font(.system(size: 36))
                  })
          }
          
          }
      }.navigationBarBackButtonHidden(true)
    
    
    
  }
}
