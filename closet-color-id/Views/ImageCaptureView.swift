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
    @State var image: UIImage?
    @State var showUnsavedArticleView: Bool = false
    @State var results = [PhotoColor]()
    let viewModel: ViewModel
    @State var isCustomCameraViewPresented = false
    @ObservedObject var imaggaCall: ImaggaCalls
    @State var colors: [PhotoColor]?
    @State var donePressed = false
    @State var article: Article?
    @State var calledImagga: Bool = false
    let appDelegate = AppDelegate()
  
    init(viewModel: ViewModel, image: UIImage?){
      self.viewModel = viewModel
      self.imaggaCall = ImaggaCalls(viewModel: viewModel)
    }
    func runImagga() {
      self.imaggaCall.image = image!
      self.imaggaCall.uploadImage(completion: { article in
        self.article = article
      })
    }
    
    
    var body: some View {
        NavigationView {
                ZStack {
                    Text("Take a Picture!")
                    if self.image != nil && self.calledImagga != true {
                      Text("").onAppear{
                          self.calledImagga = true
                          self.imaggaCall.image = self.image
                        self.runImagga()
                          
                      }
                    }
                    VStack {
                        Spacer()
                        if viewModel.article != nil {
                            Text("").onAppear{
                                self.viewModel.updateArticles()
                                print(viewModel.article.debugDescription)
                            }
                            NavigationLink(destination: UnsavedArticleView(viewModel: viewModel, article: self.viewModel.article!), label: { Text("View saved article").font(.system(size: 36))})
                        }
                        if image == nil{
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
                                CustomCameraView(capturedImage: $image)
                            })
                        }
                    }
                }
            }
            .background(Color(red: 0.96, green: 0.94, blue: 0.91))
            .onDisappear(perform: {
          self.image = nil
          self.imaggaCall.image = nil
          self.article = nil
          self.calledImagga = false
                self.viewModel.article = nil //IS THIS GOOD
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

