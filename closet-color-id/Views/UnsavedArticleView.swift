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
//    @State private var i = ImaggaCalls()
    @State var colors: [PhotoColor]
  var body: some View {
      ScrollView{
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
                ImageCaptureView(imaggaCall: ImaggaCalls(), viewModel: viewModel)
                .animation(.spring())
                .transition(.slide)
            }) {
              Text("Retake photo")
            }
              Spacer()
              
              List{
                  ForEach(colors, id: \.self) { color in
                      /*@START_MENU_TOKEN@*/Text(color.primaryHex)/*@END_MENU_TOKEN@*/
                  }
              }
          }
      }
    
//    .onAppear{
//        i.uploadImage(image: image)
//        colors = i.colors! //UNSAFE
//    }
  }
  
}
