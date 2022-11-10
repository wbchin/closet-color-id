import Foundation
import SwiftUI
            
struct TagCategoryView: View {
    @State private var capturedImage: UIImage? = UIImage(named:"pusheen.png")
  let viewModel: ViewModel
  let article: Article
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
            Image(uiImage: capturedImage!).resizable().scaledToFit().padding()
      //      Spacer()
      //
            Button(action: {
//              TagSubcategoryView(viewModel: viewModel, image: capturedImage!, primary_color_name: "", primary_color_family: "", primary_color_hex: "", secondary_color_name: "", secondary_color_hex: "", secondary_color_family: "", complimentary_color_name: "", complimentary_color_hex: "", complimentary_color_family: "", cat: "", subcategory: "")
                isShowingCat = false
                cat = "top"
              viewModel.tagArticleCategory(category: "top", article: article)
              subcats = SubcategoryName.subcategoryNamesShirts
            }) {
              Text("Top")
            }
      //
            Button(action: {
//              TagSubcategoryView(viewModel: viewModel, image: capturedImage!, primary_color_name: "", primary_color_family: "", primary_color_hex: "", secondary_color_name: "", secondary_color_hex: "", secondary_color_family: "", complimentary_color_name: "", complimentary_color_hex: "", complimentary_color_family: "", cat: "", subcategory: "")
                isShowingCat = false
              viewModel.tagArticleCategory(category: "bottom", article: article)
              subcats = SubcategoryName.subcategoryNamesBottoms
            }) {
              Text("Bottom")
            }
      //
      //
      //
            Button(action: {
//              TagSubcategoryView(viewModel: viewModel, image: capturedImage!, primary_color_name: "", primary_color_family: "", primary_color_hex: "", secondary_color_name: "", secondary_color_hex: "", secondary_color_family: "", complimentary_color_name: "", complimentary_color_hex: "", complimentary_color_family: "", cat: "", subcategory: "")
                isShowingCat = false
              viewModel.tagArticleCategory(category: "top", article: article)
              subcats = SubcategoryName.subcategoryNamesFootwear
            }) {
              Text("Footwear")
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
                destination: TagSubcategoryView(viewModel: viewModel, image: capturedImage!, subcategory: subcats, article: article),
                label:{
                  Text("Done")
                })
            }
          }
      }.navigationBarBackButtonHidden(true)
    
  }
}
