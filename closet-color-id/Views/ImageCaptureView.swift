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
    @ObservedObject var imaggaCall: ImaggaCalls
    @State var colors: [PhotoColor]?
    func runImagga(capturedImage: UIImage){
        imaggaCall.uploadImage(image: capturedImage)
    }
    func callImagga(){
        if let picture = capturedImage{
            ImaggaCalls().uploadImage(image: picture)
            print("run uplaod image")
        }
    }
    func getColors()-> [PhotoColor]?{
        if ImaggaCalls().colors != nil{
            return ImaggaCalls().colors
        }
        print("nil")
        return nil
    }
        let viewModel: ViewModel
  
        var body: some View {
            ZStack {
                if colors == nil{
                    Text("").onAppear{
                        colors = getColors()
                        sleep(1)
                    }
                    if capturedImage != nil {
                        Text("").onAppear{
                            callImagga()
                        }
                        
                        if colors != nil{
                            UnsavedArticleView(viewModel: viewModel, image: capturedImage!, colors: colors!)
                        }
                    } else {
                        Color(UIColor.systemBackground)
                    }
                }
                
                
                VStack {
                  Button(action: {
                    self.viewModel.saveArticle()
//                    UnsavedArticleView(viewModel: viewModel, image: capturedImage!)
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

//struct ImageCaptureView_Previews: PgitreviewProvider {
//    static var previews: some View {
//        ImageCaptureView()
//    }
//}
