//
//  TagCategoryView.swift
//  closet-color-id
//
//  Created by Allison Cao on 11/8/22.
//

import Foundation
import SwiftUI
            
struct TagCategoryView: View {
    @State private var capturedImage: UIImage? = UIImage(named:"pusheen.png")
  let viewModel: ViewModel
  var image: UIImage
  let primary_color_name: String
  let primary_color_family: String
  let primary_color_hex: String
  let secondary_color_name: String
  let secondary_color_hex: String
  let secondary_color_family: String
  let complimentary_color_name: String
  let complimentary_color_hex: String
  let complimentary_color_family: String
  @State private var cat = ""
    @State private var subcats = [""]
  @State var isShowingCat = true
    
  
  var body: some View {
      NavigationView{
          VStack {
            // insert image here
            Image(uiImage: image).resizable().scaledToFit().padding()
      //      Spacer()
      //
            Button(action: {
//              TagSubcategoryView(viewModel: viewModel, image: capturedImage!, primary_color_name: "", primary_color_family: "", primary_color_hex: "", secondary_color_name: "", secondary_color_hex: "", secondary_color_family: "", complimentary_color_name: "", complimentary_color_hex: "", complimentary_color_family: "", cat: "", subcategory: "")
                isShowingCat = false
                cat = "top"
              subcats = SubcategoryName.subcategoryNamesShirts
            }) {
              Text("Top")
            }
      //
            Button(action: {
//              TagSubcategoryView(viewModel: viewModel, image: capturedImage!, primary_color_name: "", primary_color_family: "", primary_color_hex: "", secondary_color_name: "", secondary_color_hex: "", secondary_color_family: "", complimentary_color_name: "", complimentary_color_hex: "", complimentary_color_family: "", cat: "", subcategory: "")
                isShowingCat = false
                cat = "bottom"
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
                cat = "footwear"
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
                destination: TagSubcategoryView(viewModel: viewModel, image: capturedImage!, primary_color_name: "", primary_color_family: "", primary_color_hex: "", secondary_color_name: "", secondary_color_hex: "", secondary_color_family: "", complimentary_color_name: "", complimentary_color_hex: "", complimentary_color_family: "", cat: cat, subcategory: subcats),
                label:{
                  Text("Done")
                })
            }
          }
      }.navigationBarBackButtonHidden(true)
    
  }
}
