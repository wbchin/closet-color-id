//
//  ImageCaptureView.swift
//  closet-color-id
//
//  Created by Waverly Chin on 11/2/22.
//

import SwiftUI

struct ImageCaptureView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var capturedImage: UIImage? = UIImage(named: "pusheen.png")
    @State var showUnsavedArticleView: Bool = false
        @State private var isCustomCameraViewPresented = false
        let viewModel: ViewModel
        var body: some View {
            if showUnsavedArticleView {
              UnsavedArticleView(viewModel: viewModel, image: capturedImage!)
                    .animation(.spring())
                    .transition(.slide)
            }
            ZStack {
                if capturedImage != nil {
                    Image(uiImage: capturedImage!)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                  UnsavedArticleView(viewModel: viewModel, image: capturedImage!)
                } else {
                    Color(UIColor.systemBackground)
                }
                
                VStack {
                  Button(action: {
                    self.viewModel.saveArticle()
                    UnsavedArticleView(viewModel: viewModel, image: capturedImage!)
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
