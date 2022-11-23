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
    //KEEP FOR TESTING PURPOSES
    func centerCrop() -> CGImage {
        let sourceImage = UIImage(data:article.image_data!)

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
   
    var body: some View {
        NavigationView {
            VStack{
                let articleStyle = article.articleStyles?.allObjects.first as! ArticleStyle
                Image(uiImage: UIImage(data: article.image_data!)!).resizable().scaledToFit().padding().rotationEffect(.degrees(90))
                    .accessibilityLabel("Image of article. See below for article information.")
                //FOR TESTING CROP
//                Image(uiImage: UIImage(cgImage: centerCrop())).resizable().scaledToFit().padding().rotationEffect(.degrees(90))
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

