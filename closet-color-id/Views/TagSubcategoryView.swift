import Foundation
import SwiftUI

struct TagSubcategoryView: View {
  let viewModel: ViewModel
  var image: UIImage
  let subcategory: [String]
  let style = ""
  let article: Article
    @State private var capturedImage: UIImage? = UIImage(named:"shirt.png")
  @State var isShowingSubcat = true
  
  var body: some View {
      NavigationView{
          VStack{
              Image(uiImage: image).resizable().scaledToFit().padding()
              ForEach(SubcategoryName.subcategoryNamesShirts, id: \.self) { sub in
                Button(action: {
                  isShowingSubcat = false
                  viewModel.tagArticleCategory(category: sub, article: article)
                }) {
                  Text(sub)
                }
              }
//              if (cat == "top") {
//                ForEach(SubcategoryName.subcategoryNamesShirts, id: \.self) { sub in
//                  Button(action: {
//                    isShowingSubcat = false
//                    let subcategory = sub
//                  }) {
//                    Text(sub)
//                  }
//                }
//              }
//
//              if (cat == "bottom") {
//                ForEach(SubcategoryName.subcategoryNamesBottoms, id: \.self) { sub in
//                  Button(action: {
//                    isShowingSubcat = false
//                    let subcategory = sub
//                  }) {
//                    Text(sub)
//                  }
//                }
//              }
//
//              if (cat == "footwear") {
//                ForEach(SubcategoryName.subcategoryNamesFootwear, id: \.self) { sub in
//                  Button(action: {
//                    isShowingSubcat = false
//                    let subcategory = sub
//                  }) {
//                    Text(sub)
//                  }
//                }
//              }
              if !isShowingSubcat {
                NavigationLink (
                  destination: TagStyleView(viewModel: viewModel, article: article),
                  label:{
                    Text("Done")
                  })
          }
          
          }
      }.navigationBarBackButtonHidden(true)
    
    
    
  }
}
