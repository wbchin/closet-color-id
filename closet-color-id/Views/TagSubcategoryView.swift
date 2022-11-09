//
//  TagSubcategoryView.swift
//  closet-color-id
//
//  Created by Allison Cao on 11/8/22.
//

import Foundation
import SwiftUI

struct TagSubcategoryView: View {
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
  let cat: String
  let subcategory: String
  let style = ""
  let capturedImage = UIImage(named:"pusheen.png")
  @State var isShowingSubcat = false
  
  var body: some View {
    if (cat == "top") {
      ForEach(SubcategoryName.subcategoryNamesShirts, id: \.self) { sub in
        Button(action: {
          isShowingSubcat = false
          let subcategory = sub
        }) {
          Text(sub)
        }
      }
    }
    
    if (cat == "bottom") {
      ForEach(SubcategoryName.subcategoryNamesBottoms, id: \.self) { sub in
        Button(action: {
          isShowingSubcat = false
          let subcategory = sub
        }) {
          Text(sub)
        }
      }
    }
    
    if (cat == "footwear") {
      ForEach(SubcategoryName.subcategoryNamesFootwear, id: \.self) { sub in
        Button(action: {
          isShowingSubcat = false
          let subcategory = sub
        }) {
          Text(sub)
        }
      }
    }
    
    if isShowingSubcat != true {
//      NavigationLink (
//        destination: TagStyleView(viewModel: viewModel, image: capturedImage!, primary_color_name: "", primary_color_family: "", primary_color_hex: "", secondary_color_name: "", secondary_color_hex: "", secondary_color_family: "", complimentary_color_name: "", complimentary_color_hex: "", complimentary_color_family: "", cat: cat, subcategory: subcategory),
//        label:{
//          Text("Done")
//        })
    }
  }
}
