//
//  UnsavedArticleView.swift
//  closet-color-id
//
//  Created by Allison Cao on 11/8/22.
//

import Foundation
import SwiftUI

struct UnsavedArticleView: View {
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
  let capturedImage = UIImage(named:"pusheen.png")
  @State private var isShowingSave = true
  var body: some View {
      NavigationView{
          VStack {
            // insert image here
            Image(uiImage: image).resizable().scaledToFit().padding()
            
            
            Button(action: {
              isShowingSave = false
            }) {
              Text("Save to wardrobe")
            }
            
      //      Button(action: {
      //        isShowingSave = false
      //        ImageCaptureView(viewModel: viewModel)
      //      }) {
      //        Text("Retake photo")
      //      }
            
            if !isShowingSave {
//                TagCategoryView(viewModel: viewModel, image: capturedImage!, primary_color_name: "", primary_color_family: "", primary_color_hex: "", secondary_color_name: "", secondary_color_hex: "", secondary_color_family: "", complimentary_color_name: "", complimentary_color_hex: "", complimentary_color_family: "")
              NavigationLink (
                destination: TagCategoryView(viewModel: viewModel, image: capturedImage!, primary_color_name: "", primary_color_family: "", primary_color_hex: "", secondary_color_name: "", secondary_color_hex: "", secondary_color_family: "", complimentary_color_name: "", complimentary_color_hex: "", complimentary_color_family: ""),
                label:{
                  Text("Done")
                })
            }
          }
      }.navigationBarBackButtonHidden(true)
    
  }
  
}
