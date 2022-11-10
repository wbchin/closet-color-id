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
          NavigationLink(destination: ArticleView(article: self.imaggaCall.article, viewModel: viewModel), label: { Text("view saved article")})
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
