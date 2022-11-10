//
//  ImageCaptureView.swift
//  closet-color-id
//
//  Created by Waverly Chin on 11/2/22.
//

import SwiftUI
import CoreData

struct ImageCaptureView: View {
//  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
//  @State private var capturedImage: UIImage? = nil
//  @State private var isCustomCameraViewPresented = false
//  let viewModel: ViewModel
//  var shirt: UIImage = UIImage(named: "shirt.png")!
//
//  var body: some View {
//    ZStack {
//      if capturedImage != nil {
//        Image(uiImage: capturedImage!)
//          .resizable()
//          .scaledToFill()
//          .ignoresSafeArea()
//      } else {
//        Color(UIColor.systemBackground)
//      }
//
//      VStack {
//        Button(action: {
//          self.viewModel.saveArticle(image_data: shirt.pngData()!, primary_color_name: "pink", primary_color_family: "red", primary_color_hex: "#ffffff", secondary_color_name: "black", secondary_color_family: "black", secondary_color_hex: "#000000")
//        }) {
//          Text("Done")
//        }
//        Spacer()
//        Button(action: {
//          isCustomCameraViewPresented.toggle()
//        }, label: {
//          Image(systemName: "camera.fill")
//            .font(.largeTitle)
//            .padding()
//            .background(Color.black)
//            .foregroundColor(.white)
//            .clipShape(Circle())
//        })
//        .padding(.bottom)
//        .sheet(isPresented: $isCustomCameraViewPresented, content: {
//          CustomCameraView(capturedImage: $capturedImage)
//        })
//      }
//    }
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var image: UIImage? = nil
    @State var showUnsavedArticleView: Bool = false
    @State var results = [PhotoColor]()
    let viewModel: ViewModel
    @State var isCustomCameraViewPresented = false
    @ObservedObject var imaggaCall: ImaggaCalls
  
//    var imaggaCall: ImaggaCalls {
//      get {
//        return ImaggaCalls(viewModel: viewModel)
//      }
//    }
    @State var colors: [PhotoColor]?
    @State var donePressed = false
    @State var article: Article? 
  @State var articleIndex: Int? = -1
    let appDelegate = AppDelegate()
  
    init(viewModel: ViewModel, image: UIImage?){
          self.viewModel = viewModel
      self.imaggaCall = ImaggaCalls(viewModel: viewModel)
      //self.image = image// << here !!
      }
      func runImagga() {
        NSLog("imagga run")
        self.imaggaCall.image = image!
        self.imaggaCall.uploadImage(completion: { article in
           self.article = article
        })
      }
    
    
    var body: some View {
      NavigationView {
        ZStack {
          if self.image != nil{
            Image(uiImage: image!)
                                .resizable()
                                .scaledToFill()
                                .ignoresSafeArea()
              Text("").onAppear{
                let _ = print("ATTEMPT TO SET IMAGGA IMAGE")
                self.imaggaCall.image = image!
                self.runImagga()
              }
          }
//          if self.image != nil {
//                Image(uiImage: image!)
//                    .resizable()
//                    .scaledToFill()
//                    .ignoresSafeArea()
//            } else {
//                Color(UIColor.systemBackground)
//            }
          
          
          VStack {
            Spacer()
            if self.article != nil {
              //              NSLog(self.viewModel.arts.count)
              let _ = print("COUNT")
              let _ = print(self.viewModel.arts.count)
//              NavigationLink(destination: UnsavedArticleView(viewModel: viewModel, article: self.viewModel.arts.last!), label: { Text("view saved article")})
            }
            Button(action: {
              //              NSLog(self.imaggaCall.article.debugDescription)
              isCustomCameraViewPresented.toggle()
            }, label: {
              Image(systemName: "camera.fill")
                .font(.largeTitle)
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .clipShape(Circle())
            })
            .padding(.bottom)
            .sheet(isPresented: $isCustomCameraViewPresented, content: {
              CustomCameraView(capturedImage: $image)
            })
           
          }
          }
        }
    }
  }
  
  private enum Localization {
    static let addPhotoTitle = NSLocalizedString("Add Photo", comment: "Button title for Add Photo")
  }
  
  
  //struct ImageCaptureView_Previews: PgitreviewProvider {
  //    static var previews: some View {
  //        ImageCaptureView()
  //    }
  //}

