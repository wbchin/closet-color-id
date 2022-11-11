import Foundation
import SwiftUI
            
struct TagCategoryView: View {
//    @State private var capturedImage: UIImage? = UIImage(named:"shirt.png")
  let viewModel: ViewModel
  let article: Article
//  var imaggaCall: ImaggaCalls
//  var image: UIImage
//  let primary_color_name: String
//  let primary_color_family: String
//  let primary_color_hex: String
//  let secondary_color_name: String
//  let secondary_color_hex: String
//  let secondary_color_family: String
//  let complimentary_color_name: String
//  let complimentary_color_hex: String
//  let complimentary_color_family: String
  @State private var cat = ""
    @State private var subcats = [""]
  @State var isShowingCat = true
    
  
  var body: some View {
      NavigationView{
          VStack {
            // insert image here
              Image(uiImage: UIImage(data: article.image_data!)!).resizable().scaledToFit().padding().rotationEffect(.degrees(90))
      //      Spacer()
      //
            Button(action: {
//              TagSubcategoryView(viewModel: viewModel, image: capturedImage!, primary_color_name: "", primary_color_family: "", primary_color_hex: "", secondary_color_name: "", secondary_color_hex: "", secondary_color_family: "", complimentary_color_name: "", complimentary_color_hex: "", complimentary_color_family: "", cat: "", subcategory: "")
                isShowingCat = false
                cat = "top"
                subcats = SubcategoryName.subcategoryNamesShirts
                viewModel.tagArticleCategory(category: "top", article: article)
            }) {
              Text("Top").frame(maxHeight: .infinity, alignment: .bottom).font(.system(size: 36))
            }
      //
            Button(action: {
//              TagSubcategoryView(viewModel: viewModel, image: capturedImage!, primary_color_name: "", primary_color_family: "", primary_color_hex: "", secondary_color_name: "", secondary_color_hex: "", secondary_color_family: "", complimentary_color_name: "", complimentary_color_hex: "", complimentary_color_family: "", cat: "", subcategory: "")
                isShowingCat = false
              subcats = SubcategoryName.subcategoryNamesBottoms
                viewModel.tagArticleCategory(category: "bottom", article: article)
            }) {
              Text("Bottom").font(.system(size: 36))
            }
      //
      //
      //
            Button(action: {
//              TagSubcategoryView(viewModel: viewModel, image: capturedImage!, primary_color_name: "", primary_color_family: "", primary_color_hex: "", secondary_color_name: "", secondary_color_hex: "", secondary_color_family: "", complimentary_color_name: "", complimentary_color_hex: "", complimentary_color_family: "", cat: "", subcategory: "")
                isShowingCat = false
                subcats = SubcategoryName.subcategoryNamesFootwear
              viewModel.tagArticleCategory(category: "top", article: article)
            }) {
              Text("Footwear").font(.system(size: 36))
            }
      //
//            Button(action: {
//              TagSubcategoryView(viewModel: viewModel, image: capturedImage!, primary_color_name: "", primary_color_family: "", primary_color_hex: "", secondary_color_name: "", secondary_color_hex: "", secondary_color_family: "", complimentary_color_name: "", complimentary_color_hex: "", complimentary_color_family: "", cat: "", subcategory: "")
//            }) {
//              Text("Save to wardrobe")
//            }
      
      //      Button(action: {
      //        ImageCaptureView(viewModel: viewModel)
      //      }) {
      //        Text("Retake photo")
      //      }
            
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
