//
//  CustomCameraView.swift
//  closet-color-id
//
//  Created by Waverly Chin on 11/3/22.
//

import SwiftUI

struct CustomCameraView: View {
    
    let cameraService = CameraSevice()
    @Binding var capturedImage: UIImage?
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        let _ = print("CUSTOM CAMERA VIEW")
        ZStack {
            CameraView(cameraService: cameraService) { result in
                switch result {
                case .success(let photo):
                    if let data = photo.fileDataRepresentation() {
                        capturedImage = UIImage(data: data)
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        print("Error: no image data found")
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
            
            VStack {
                Spacer()
                Button(action: {
                    cameraService.capturePhoto()
                }, label: {
                    Image(systemName: "circle")
                        .font(.system(size: 72))
                        .foregroundColor(.white)
                })
                .padding(.bottom)
                .accessibilityLabel("Capture image button")
            }
        }
    }
}

