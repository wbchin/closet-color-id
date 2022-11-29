//
//  OutfitView.swift
//  closet-color-id
//
//  Created by Waverly Chin on 11/2/22.
//

import SwiftUI

struct OutfitView: View {
    var outfit: Outfit
    let viewModel: ViewModel
    var images = [UIImage]()
    let columns = [
  //    GridItem(.flexible()),
  //    GridItem(.flexible()),
//      GridItem(.flexible()),
      GridItem(.flexible())
    ]
    func imageArray() -> [UIImage]{
        var i = [UIImage]()
        for article in viewModel.retrieveArticlesForOutfit(outfit: outfit)! {
            i.append(UIImage(data: article.image_data!)!)
        }
        return i
    }
    func collageImage(rect: CGRect, images: [UIImage]) -> UIImage {
            if images.count == 1 {
                return images.first!
            }
            UIGraphicsBeginImageContextWithOptions(rect.size, false,  UIScreen.main.scale)
            //Charecteristics of output
            let totalNumberOfColumns: CGFloat = 2
            let totalNumberOfRows: CGFloat = 2
            //Process
            let heightOfSubImage: CGFloat = rect.height/totalNumberOfRows
            let widthOfSubImage = rect.width/totalNumberOfColumns
            var columnNumber = 0
            var rowNumber = 0
            var i=0
            while i<images.count {
                let rectToDrawIn = CGRect(x: CGFloat(columnNumber)*widthOfSubImage, y: CGFloat(rowNumber)*heightOfSubImage, width: widthOfSubImage, height: heightOfSubImage)
                images[i].draw(in: rectToDrawIn)
                if columnNumber == (Int(totalNumberOfColumns) - 1){
                    rowNumber = rowNumber + 1
                    columnNumber = 0
                }
                else {
                    columnNumber = columnNumber + 1
                }
                i = i + 1
            }
            let outputImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return outputImage!
        }
    
    var body: some View {
        NavigationView {
            ScrollView{
//                Image(uiImage: collageImage(rect: CGRect(x: 0, y: 0, width: 200, height: 200), images: imageArray()))
                LazyVGrid(columns: [GridItem(.flexible())]){
                    ForEach(viewModel.retrieveArticlesForOutfit(outfit: outfit)!, id: \.self){ article in
                        Image(uiImage: UIImage(data: article.image_data!)!).resizable().scaledToFit().padding()
                            //.accessibilityLabel("Image of article. See below for article information.")

                    }
                }
                .background(Color.red)
                .cornerRadius(15)
                ShareLink(item: Image(uiImage: collageImage(rect: CGRect(x: 0, y: 0, width: 200, height: 200), images: imageArray())), preview: SharePreview("Outfit", image: Image(uiImage: collageImage(rect: CGRect(x: 0, y: 0, width: 200, height: 200), images: imageArray())))){
                    Label("Share outfit", systemImage:  "square.and.arrow.up")
                }
            }
            
        }
//        .onAppear(perform: {
//            self.images = self.imageArray()
//        })
    }
    
}

//struct OutfitView_Previews: PreviewProvider {
//    static var previews: some View {
//        OutfitView()
//    }
//}
