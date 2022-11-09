//
//  TagCategoryView.swift
//  closet-color-id
//
//  Created by Allison Cao on 11/8/22.
//

import Foundation
import SwiftUI

struct TagCategoryView: View {
  @State private var capturedImage: UIImage? = nil
  let viewModel: ViewModel
  var image: UIImage
  let article: Article
  let cat = ""
  @State var isShowingCat = false
  
  var body: some View {
    VStack {
      // insert image here
      Image(uiImage: image).resizable().scaledToFit().padding()
      
      Spacer()
      
      Button(action: {
        TagSubcategoryView(viewModel: viewModel, image: capturedImage!, primary_color_name: "", primary_color_family: "", primary_color_hex: "", secondary_color_name: "", secondary_color_hex: "", secondary_color_family: "", complimentary_color_name: "", complimentary_color_hex: "", complimentary_color_family: "", cat: "", subcategory: "")
        let cat = "top"
        let subcats = SubcategoryName.subcategoryNamesShirts
      }) {
        Text("Top")
      }
      
      Button(action: {
        TagSubcategoryView(viewModel: viewModel, image: capturedImage!, primary_color_name: "", primary_color_family: "", primary_color_hex: "", secondary_color_name: "", secondary_color_hex: "", secondary_color_family: "", complimentary_color_name: "", complimentary_color_hex: "", complimentary_color_family: "", cat: "", subcategory: "")
        let cat = "bottom"
        let subcats = SubcategoryName.subcategoryNamesBottoms
      }) {
        Text("Bottom")
      }
      
      
      
      Button(action: {
        TagSubcategoryView(viewModel: viewModel, image: capturedImage!, primary_color_name: "", primary_color_family: "", primary_color_hex: "", secondary_color_name: "", secondary_color_hex: "", secondary_color_family: "", complimentary_color_name: "", complimentary_color_hex: "", complimentary_color_family: "", cat: "", subcategory: "")
        let cat = "footwear"
        let subcats = SubcategoryName.subcategoryNamesFootwear
      }) {
        Text("Footwear")
      }
      
      Button(action: {
        TagSubcategoryView(viewModel: viewModel, image: capturedImage!, primary_color_name: "", primary_color_family: "", primary_color_hex: "", secondary_color_name: "", secondary_color_hex: "", secondary_color_family: "", complimentary_color_name: "", complimentary_color_hex: "", complimentary_color_family: "", cat: "", subcategory: "")
      }) {
        Text("Save to wardrobe")
      }
      
      Button(action: {
        ImageCaptureView(viewModel: viewModel)
      }) {
        Text("Retake photo")
      }
      
      if isShowingCat != true {
        NavigationLink (
          destination: TagSubcategoryView(viewModel: viewModel, image: capturedImage!, primary_color_name: "", primary_color_family: "", primary_color_hex: "", secondary_color_name: "", secondary_color_hex: "", secondary_color_family: "", complimentary_color_name: "", complimentary_color_hex: "", complimentary_color_family: "", cat: cat, subcategory: ""),
          label:{
            Text("Done")
          })
      }
    }
  }
}
