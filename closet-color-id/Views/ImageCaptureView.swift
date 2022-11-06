//
//  ImageCaptureView.swift
//  closet-color-id
//
//  Created by Waverly Chin on 11/2/22.
//

import SwiftUI

struct ImageCaptureView: View {
//    let viewController: ViewController
  let viewModel: ViewModel
//    private let session = AVCaptureSession()
    var body: some View {
      NavigationView {
        VStack{
          Text("Camera")
          //            BottomNavigation().frame(alignment: .bottom)
          Button(action: {
            self.viewModel.saveArticle()
          }) {
            Text("Done")
          }
        }
      }
      .navigationBarTitle("New Article")
      .navigationBarItems(trailing:
        Button(action: {
          self.viewModel.saveArticle()
        }) {
          Text("Done")
        }
      )
    }
}

//struct ImageCaptureView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageCaptureView()
//    }
//}
