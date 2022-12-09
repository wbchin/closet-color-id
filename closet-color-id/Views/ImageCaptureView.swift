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
    @State var image: UIImage? //= UIImage(named: "pusheen")
    let viewModel: ViewModel
    @State var isCustomCameraViewPresented = true
    @ObservedObject var imaggaCall: ImaggaCalls
    @State var article: Article?
    @State var calledImagga: Bool = false
    let appDelegate = AppDelegate()
  
    init(viewModel: ViewModel, image: UIImage?){
      self.viewModel = viewModel
      self.imaggaCall = ImaggaCalls(viewModel: viewModel)
    }
    func runImagga() {
        self.imaggaCall.imageCropped = UIImage(cgImage: centerCrop())
        self.imaggaCall.image = self.rotate(radians: 2*(.pi), image: image!)
      self.imaggaCall.uploadImage(completion: { article in
        self.article = article
      })
    }
    
    func centerCrop() -> CGImage {
        let sourceImage = image

        // The shortest side
        let sideLength = min(
            sourceImage!.size.width,
            sourceImage!.size.height
        )

        // Determines the x,y coordinate of a centered
        // sideLength by sideLength square
        let sourceSize = sourceImage!.size
        let xOffset = (sourceSize.width - sideLength/2) / 2.0
        let yOffset = (sourceSize.height - sideLength/2) / 2.0
        print(yOffset)
        print(xOffset)
        print(sideLength/2)
        // The cropRect is the rect of the image to keep,
        // in this case centered
        let cropRect = CGRect(
            x: xOffset,
            y: yOffset,
            width: sideLength/2,
            height: sideLength/2
        ).integral

        // Center crop the image
        let sourceCGImage = sourceImage?.cgImage!
        let croppedCGImage = sourceCGImage!.cropping(
            to: cropRect
        )!
        return croppedCGImage
    }
    
    func rotate(radians: Float, image: UIImage) -> UIImage? {
            var newSize = CGRect(origin: CGPoint.zero, size: image.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
            // Trim off the extremely small float value to prevent core graphics from rounding it up
            newSize.width = floor(newSize.width)
            newSize.height = floor(newSize.height)

            UIGraphicsBeginImageContextWithOptions(newSize, false, image.scale)
            let context = UIGraphicsGetCurrentContext()!

            // Move origin to middle
            context.translateBy(x: newSize.width/2, y: newSize.height/2)
            // Rotate around middle
            context.rotate(by: CGFloat(radians))
            // Draw the image at its center
            image.draw(in: CGRect(x: -image.size.width/2, y: -image.size.height/2, width: image.size.width, height: image.size.height))

            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return newImage
        }
    
    var body: some View {
        NavigationView {
                ZStack {
                    VStack {
//                        Spacer()
                        if self.image != nil && self.calledImagga != true {
                          Text("").onAppear{
                              self.calledImagga = true
                              self.imaggaCall.image = self.rotate(radians: 2*(.pi), image: self.image!)
                            self.runImagga()
                          }
                        }
                      if self.viewModel.article != nil && self.viewModel.article!.image_data != nil {
                            
                            Text("").onAppear{
                                self.viewModel.updateArticles()
                              print(self.viewModel.article.debugDescription)
//                                isCustomCameraViewPresented = false
//                                viewModel.image = nil
                            }
                            Spacer()
                          
                            Image(uiImage: UIImage(data: (self.viewModel.article!.image_data)!)!).resizable().scaledToFit().padding()
                            Spacer()
                          NavigationLink (
                            destination: TagCategoryView(viewModel: viewModel, article: self.viewModel.article!),
                              label:{
                                  Text("Done")
                                      .font(.system(size: 30))
                              })
//                            NavigationLink(destination: UnsavedArticleView(viewModel: viewModel, article: self.viewModel.article!), label: { Text("View saved article").font(.system(size: 36))})
                            Text("Retake picture").font(.system(size: 36)).onTapGesture{
                                self.viewModel.article = nil
                                self.image = nil
                                self.viewModel.image = nil
                                self.imaggaCall.image = nil
                                self.calledImagga = false
                                self.isCustomCameraViewPresented = true
                        
                          }
                            
//                            NavigationLink(destination: ImageCaptureView( viewModel: viewModel, image: viewModel.image), )
                        }
                        if self.image == nil{
//                            let _ = print("VM IMAGE NIL")
//                            Button(action: {
//                                isCustomCameraViewPresented.toggle()
//                            }, label: {
//                                Image(systemName: "camera.fill")
//                                    .font(.largeTitle)
//                                    .padding()
//                                    .background(Color.black)
//                                    .foregroundColor(.white)
//                                    .clipShape(Circle())
//                            })
//                            .padding(.bottom)
                            Spacer()
                            .sheet(isPresented: $isCustomCameraViewPresented, content: {
                                CustomCameraView(capturedImage: $image)
                            })
                        }
                    }
                }
            }
            .background(Color(red: 0.96, green: 0.94, blue: 0.91))
            .onDisappear(perform: {
//                let _ = print("LEAVING")
              self.viewModel.article = nil
              self.viewModel.deleteUntaggedArticles(completion: {out in })
              self.viewModel.updateArticles()
              self.image = nil
              self.imaggaCall.image = nil
              self.article = nil
              self.calledImagga = false
                self.isCustomCameraViewPresented = false
        })
            .onAppear(perform: {
                
                self.isCustomCameraViewPresented = true
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

