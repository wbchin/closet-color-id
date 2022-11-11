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
    @State var colors: [PhotoColor]?
    @State var donePressed = false
    @State var article: Article? 
    //@State var articleIndex: Int? = -1
    @State var calledImagga: Bool = false
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
          Text("ImageCaptureView")
          if self.image != nil && self.calledImagga != true {
            Text("").onAppear{
              let _ = self.calledImagga = true
              let _ = print("entered self.image != nil")
              Image(uiImage: image!).resizable().scaledToFit().padding()
              let _ = print("ATTEMPT TO SET IMAGGA IMAGE")
              let _ = self.imaggaCall.image = self.image!
              let _ = self.runImagga()
            }
          }
          VStack {
            Spacer()
            if self.article != nil {
              //              NSLog(self.viewModel.arts.count)
              
              //let _ = self.viewModel.updateArticles()
              Text("").onAppear{
                self.viewModel.updateArticles()
                let _ = print("COUNT")
                let _ = print(self.viewModel.arts.count)
              }
              NavigationLink(destination: UnsavedArticleView(viewModel: viewModel, article: self.viewModel.arts[self.viewModel.arts.count-1]), label: { Text("view saved article")})
            }
              if image == nil{
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
        }.onDisappear(perform: {
//          self.viewModel.deleteUnstyledArticles()
//          self.viewModel.updateArticles()
//          self.viewModel.deleteUntaggedArticles()
//          self.viewModel.updateArticles()
          self.image = nil
          self.imaggaCall.image = nil
          self.article = nil
          self.calledImagga = false
        })
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

