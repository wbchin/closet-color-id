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
  let article: Article
//    let image: UIImage?
  @State private var isShowingSave = true
  @State private var isShowingSubcats = false
  @State private var isShowingCats = false
  @State private var isShowingStyles = false
//    @State private var i = ImaggaCalls()
//    @State var colors: [PhotoColor]
  var body: some View {
    NavigationView{
              VStack {
                // insert image here
                  Image(uiImage: UIImage(data:article.image_data!)!).resizable().scaledToFit().padding()


                Button(action: {
                  NSLog(self.article.debugDescription)
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
                    destination: TagCategoryView(viewModel: viewModel, article: article),
                    label:{
                      Text("Done")
                    })
                }
              }
          }.navigationBarBackButtonHidden(true)

//      ScrollView{
//          HStack {
//            // insert image here
//            Image(uiImage: image).resizable().scaledToFit().padding()
//
//            Spacer()
//
//            // if isShowingSave != true {
//            //   NavigationLink (
//            //     destination: TagCategoryView(viewModel: viewModel, image: capturedImage!, primary_color_name: "", primary_color_family: "", primary_color_hex: "", secondary_color_name: "", secondary_color_hex: "", secondary_color_family: "", complimentary_color_name: "", complimentary_color_hex: "", complimentary_color_family: ""),
//            //     label:{
//            //       Text("Done")
//            //     })
//            // }
//
//            Button(action: {
//              isShowingSave = false
//            }) {
//              Text("Save to wardrobe")
//            }
//
//            Button(action: {
//              isShowingSave = false
//                ImageCaptureView(imaggaCall: ImaggaCalls(), viewModel: viewModel)
//                .animation(.spring())
//                .transition(.slide)
//            }) {
//              Text("Retake photo")
//            }
//              Spacer()
//
//              List{
//                  ForEach(colors, id: \.self) { color in
//                      /*@START_MENU_TOKEN@*/Text(color.primaryHex)/*@END_MENU_TOKEN@*/
//                  }
//              }
          }
      }
    
//    .onAppear{
//        i.uploadImage(image: image)
//        colors = i.colors! //UNSAFE
//    }
//  }
//
//}
