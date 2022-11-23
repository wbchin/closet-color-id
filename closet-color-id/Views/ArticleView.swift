//
//  ArticleView.swift
//  closet-color-id
//
//  Created by Waverly Chin on 11/2/22.
//

import SwiftUI
import CoreData

//struct ColorString: Hashable{
//    let primaryHex: String
//    let primaryName: String
//    let primaryFamily: String
//    let r: Int
//    let g: Int
//    let b: Int
//}

struct ArticleView: View {
    var article: Article
    let viewModel: ViewModel
    let backgroundColor : Color = Color(red: 141, green: 223, blue: 144)
    var comp_article: Article? {
      get {
        return self.viewModel.findComplimentaryArticle(article: self.article)
      }
    }
    
//    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {
//
//            let cgimage = image.cgImage!
//            let contextImage: UIImage = UIImage(cgImage: cgimage)
//            let contextSize: CGSize = contextImage.size
//            var posX: CGFloat = 0.0
//            var posY: CGFloat = 0.0
//            var cgwidth: CGFloat = CGFloat(width)
//            var cgheight: CGFloat = CGFloat(height)
//
//            // See what size is longer and create the center off of that
//            if contextSize.width > contextSize.height {
//                posX = ((contextSize.width - contextSize.height) / 2)
//                posY = 0
//                cgwidth = contextSize.height
//                cgheight = contextSize.height
//            } else {
//                posX = 0
//                posY = ((contextSize.height - contextSize.width) / 2)
//                cgwidth = contextSize.width
//                cgheight = contextSize.width
//            }
//
//            let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
//
//            // Create bitmap image from context using the rect
//            let imageRef: CGImage = cgimage.cropping(to: rect)!
//
//            // Create a new image based on the imageRef and rotate back to the original orientation
//            let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
//
//            return image
//        }
    
    func centerCrop() -> CGImage {
        let sourceImage = UIImage(
            data: article.image_data!
        )!

        // The shortest side
        let sideLength = min(
            sourceImage.size.width,
            sourceImage.size.height
        )
        print("MIN")
        print(sideLength)

        // Determines the x,y coordinate of a centered
        // sideLength by sideLength square
        let sourceSize = sourceImage.size
        let xOffset = (sourceSize.width - sideLength/4) / 2.0
        let yOffset = (sourceSize.height - sideLength/4) / 2.0

        // The cropRect is the rect of the image to keep,
        // in this case centered
        let cropRect = CGRect(
            x: xOffset,
            y: yOffset,
            width: sideLength/4,
            height: sideLength/4
        ).integral

        // Center crop the image
        let sourceCGImage = sourceImage.cgImage!
        let croppedCGImage = sourceCGImage.cropping(
            to: cropRect
        )!
        return croppedCGImage
    }
   
    var body: some View {
        NavigationView {
            VStack{
                let articleStyle = article.articleStyles?.allObjects.first as! ArticleStyle
                Image(uiImage: UIImage(data: article.image_data!)!).resizable().scaledToFit().padding().rotationEffect(.degrees(90))
//                    .accessibilityLabel("Image of article. See below for article information.")
                Image(uiImage: UIImage(cgImage: centerCrop())).resizable().scaledToFit().padding().rotationEffect(.degrees(90))
                HStack {
                    Text(article.category!)
                        .padding()
                        .border(Color(red: 0.30, green: 0.11, blue: 0.00), width: 2)
                        .background(.white)
                    Text(article.subcategory!)
                        .padding()
                        .border(.white, width: 4)
                    Text((articleStyle.style?.name!)!)
                        .padding()
                        .border(.white, width: 4)
                    if comp_article == nil {
                      Text("no complimentary articles found for this article :(")
                    } else {
                      Image(uiImage: UIImage(data: comp_article!.image_data!)!).resizable().scaledToFit().padding().rotationEffect(.degrees(90))
                        .accessibilityLabel("Image of complimentary article.")
                    }
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .font(.system(size: 20))
                .textCase(.uppercase)
                HStack {
                    VStack {
                        Text(article.primary_color_name!)
                        Rectangle()
                            .fill(Color(red: Double(article.primary_r)/255,
                                        green: Double(article.primary_g)/255,
                                        blue: Double(article.primary_b)/255))
                            .frame(width: 100, height: 100)
                    }
                    .padding()
                    .border(.white, width: 4)
                    if (article.secondary_color_name != nil) {
                        VStack {
                            Text(article.secondary_color_name!)
                            Rectangle()
                                .fill(Color(red: Double(article.secondary_r)/255,
                                            green: Double(article.secondary_g)/255,
                                            blue: Double(article.secondary_b)/255))
                                .frame(width: 100, height: 100)
                        }
                        .padding()
                        .border(.white, width: 4)
                        VStack {
                            Text(article.secondary_color_family!)
                            Rectangle()
                                .fill(Color(red: Double(article.primary_r)/255,
                                            green: Double(article.primary_g)/255,
                                            blue: Double(article.primary_b)/255))
                                .frame(width: 100, height: 100)
                        }
                        .padding()
                        .border(.white, width: 4)
                    }
                    
                }
            }//.navigationBarBackButtonHidden(true)
            .background(Color(red: 0.96, green: 0.94, blue: 0.91))
        }
    }
}

