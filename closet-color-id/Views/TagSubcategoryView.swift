import Foundation
import SwiftUI

struct TagSubcategoryView: View {
  let viewModel: ViewModel
//  var image: UIImage
  //let subcategory: [String]
    let subcats: [String]
  let style = ""
  let article: Article
//  var imaggaCall: ImaggaCalls
//    @State private var capturedImage: UIImage? = UIImage(named:"shirt.png")
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
                    Text("Done").frame(maxHeight: .infinity, alignment: .bottom).font(.system(size: 36))
                  })
          }
          
          }
      }.navigationBarBackButtonHidden(true)
    
    
    
  }
}
