//
//  ImageCaptureView.swift
//  closet-color-id
//
//  Created by Waverly Chin on 11/2/22.
//

import SwiftUI
import CoreData

struct ImageCaptureView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var capturedImage: UIImage? = nil
        @State private var isCustomCameraViewPresented = false
        let viewModel: ViewModel
    var shirt: UIImage = UIImage(named: "shirt.png")!

        var body: some View {
            ZStack {
                if capturedImage != nil {
                    Image(uiImage: capturedImage!)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                } else {
                    Color(UIColor.systemBackground)
                }
                
                VStack {
                  Button(action: {
                    self.viewModel.saveArticle(image_data: shirt.pngData()!, primary_color_name: "pink", primary_color_hex: "#ffffff", primary_color_family: "red", secondary_color_name: "black", secondary_color_family: "black", secondary_color_hex: "#000000", complimentary_color_name: "egg shell", complimentary_color_family: "white", complimentary_color_hex: "#ffffff")
                  }) {
                    Text("Done")
                  }
                    Spacer()
                    Button(action: {
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
                        CustomCameraView(capturedImage: $capturedImage)
                    })
                }
            }
=======
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  @State private var capturedImage: UIImage? = UIImage(named: "pusheen.png")
  @State var showUnsavedArticleView: Bool = false
  @State var results = [PhotoColor]()
  @State private var isCustomCameraViewPresented = false
  @ObservedObject var imaggaCall: ImaggaCalls = ImaggaCalls()
  @State var colors: [PhotoColor]?
  @State var donePressed = false
  @State var article: Article? = Article()
  let appDelegate = AppDelegate()
  func runImagga(capturedImage: UIImage) {
    imaggaCall.uploadImage(image: capturedImage, completion: { (article) ->
      Void in self.article = article
    })
  }
  let viewModel: ViewModel
  
  var body: some View {
    NavigationView {
      ZStack {
        if self.colors == nil{
          Text("").onAppear{
            self.runImagga(capturedImage: capturedImage!)
          }
        
    
          if self.imaggaCall.colors != nil{
            NavigationLink(destination: UnsavedArticleView(viewModel: viewModel, article: self.imaggaCall.article), label: { Text("view saved article")})
          }
        } else {
          Color(UIColor.systemBackground)
        }
      }
        }
        
        if self.colors != nil {
          Text(self.colors!.first!.primaryName)
        }
        
        
        VStack {
            Spacer()
            Button(action: {
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
              CustomCameraView(capturedImage: $capturedImage)
            })
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
