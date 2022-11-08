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
  @State private var isShowingSave = true
  @State private var isShowingSubcats = false
  @State private var isShowingCats = false
  @State private var isShowingStyles = false
  var body: some View {
    HStack {
      // insert image here
      Image(uiImage: image).resizable().scaledToFit().padding()

      Spacer()
      
      Button(action: {
        isShowingSave = false
      }) {
        Text("Save to wardrobe")
      }
      
      Button(action: {
        isShowingSave = false
        ImageCaptureView(viewModel: viewModel)
          .animation(.spring())
          .transition(.slide)
      }) {
        Text("Retake photo")
      }
    }
  }
  
}
