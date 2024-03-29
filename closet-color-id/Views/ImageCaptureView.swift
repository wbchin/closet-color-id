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
                GeometryReader { geometry in
                    VStack (spacing: 20){
                        if self.image == nil {
                            Spacer()
                            VStack (alignment: .center){
                                Text("Want to save an article?")
                                Text("Tap the camera to take a photo.")
                            }
                            .frame(width: geometry.size.width * 0.97)
                            .padding(5)
                            .background(.white)
                            .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                            .clipShape(Capsule())
                            .shadow(color: Color(red: 0.30, green: 0.11, blue: 0.00), radius: 5, x: 0, y: 0)
                        }
                        if self.image != nil && self.calledImagga != true {
                            Text("").onAppear{
                                self.calledImagga = true
                                self.imaggaCall.image = self.rotate(radians: 2*(.pi), image: self.image!)
                                self.runImagga()
                            }.frame(width: geometry.size.width * 0.01)
                        }
                        if self.viewModel.article != nil && self.viewModel.article!.image_data != nil {
                            Image(uiImage: UIImage(data: (self.viewModel.article!.image_data)!)!).resizable().scaledToFit().cornerRadius(10).frame(width: geometry.size.width)
                            NavigationLink (
                                destination: TagCategoryView(viewModel: viewModel, article: self.viewModel.article!),
                                label:{
                                    Text("Save to wardrobe").textCase(.uppercase)
                                }
                            )
                            .bold()
                            .font(.system(size: 20))
                            .frame(width: geometry.size.width * 0.7)
                            .padding(5)
                            .background(.white)
                            .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                            .clipShape(Capsule())
                            .shadow(color: Color(red: 0.30, green: 0.11, blue: 0.00), radius: 5, x: 0, y: 0)
                            Text("Retake picture")
                                .frame(width: geometry.size.width * 0.7)
                                .padding(5)
                                .background(.white)
                                .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                                .clipShape(Capsule())
                                .shadow(color: Color(red: 0.30, green: 0.11, blue: 0.00), radius: 5, x: 0, y: 0)
                                .onTapGesture{
                                    self.viewModel.article = nil
                                    self.image = nil
                                    self.viewModel.image = nil
                                    self.imaggaCall.image = nil
                                    self.calledImagga = false
                                    self.isCustomCameraViewPresented = true
                                }
                            Text("").onAppear{
                                self.viewModel.updateArticles()
                                print(self.viewModel.article.debugDescription)
                            }.frame(width: geometry.size.width * 0.01)
                        }
                    }
                    Spacer()
                    if viewModel.image == nil || isCustomCameraViewPresented {
//                        let _ = print("IS CCV PRESENTED")
//                        let _ = print(isCustomCameraViewPresented)
                        Spacer()
                            .sheet(isPresented: $isCustomCameraViewPresented, content: {
                                CustomCameraView(capturedImage: $image)
                            })
                    }
                }
            }
            .padding()
            .background(Color(red: 0.96, green: 0.94, blue: 0.91))
        }
        .onDisappear(perform: {
            self.image = nil
            self.imaggaCall.image = nil
            self.isCustomCameraViewPresented = false
            self.calledImagga = false
        })
        .onAppear(perform: {
            self.isCustomCameraViewPresented = true
            self.viewModel.deleteUntaggedArticles(completion: {out in })
            self.viewModel.updateArticles()
            self.viewModel.article = nil
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
  

