//
//  ImageCaptureView.swift
//  closet-color-id
//
//  Created by Waverly Chin on 11/2/22.
//

import SwiftUI

struct ImageCaptureView: View {
//    @State private var showImagePickerOptions: Bool = false
//       @State private var showImagePicker: Bool = false
//       @State private var sourceType = UIImagePickerController.SourceType.photoLibrary
//       @State private var photo:UIImage?
//    var body: some View {
//            VStack {
//
//
//                Button(Localization.addPhotoTitle, action: {
//                    showImagePickerOptions = true
//                })
//                    .font(.system(size: 17))
//                    .frame(width: 200, height: 50, alignment: .center)
//                    .background(Color.blue)
//                    .foregroundColor(Color.white)
//                    .cornerRadius(10)
//                    .padding(.top, 40)
//                    .ActionSheet(showImagePickerOptions: $showImagePickerOptions, showImagePicker: $showImagePicker, sourceType: $sourceType)
//
//                Spacer()
//            }
//            .sheet(isPresented: $showImagePicker) {
//                ImagePicker(image: self.$photo, isShown: self.$showImagePicker, sourceType: self.sourceType)
//            }
//        }
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
        }
    
}

private enum Localization {
    static let addPhotoTitle = NSLocalizedString("Add Photo", comment: "Button title for Add Photo")
}

//struct ImageCaptureView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageCaptureView()
//    }
//}
