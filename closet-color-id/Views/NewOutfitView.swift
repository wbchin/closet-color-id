//
//  NewOutfitView.swift
//  closet-color-id
//
//  Created by Waverly Chin on 12/13/22.
//

import SwiftUI

struct NewOutfitView: View {
    var outfit: Outfit
    let viewModel: ViewModel
    var images = [UIImage]()
    let columns = [
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
                LazyVGrid(columns: [GridItem(.flexible())]){
                    ForEach(viewModel.organizeOutfit(outfit: outfit)!, id: \.self){ article in
                        NavigationLink(destination: ArticleView(article: article, viewModel: viewModel)){
                            Image(uiImage: UIImage(data: article.image_data!)!).resizable().scaledToFit().cornerRadius(10).padding()
                        }
                    }
                }
                .background(Color(red: 0.30, green: 0.11, blue: 0.00))
                .cornerRadius(15)
                .padding(25)
                ShareLink(item: Image(uiImage: collageImage(rect: CGRect(x: 0, y: 0, width: 500, height: 500), images: imageArray())), preview: SharePreview("Outfit", image: Image(uiImage: collageImage(rect: CGRect(x: 0, y: 0, width: 200, height: 200), images: imageArray())))){
                    Label("Share outfit", systemImage:  "square.and.arrow.up")
                }
                Spacer()
            }
            
            .background(Color(red: 0.96, green: 0.94, blue: 0.91))
        }.navigationTitle(self.outfit.name!)
        .navigationTitle(outfit.name!)
        .navigationBarBackButtonHidden(true)
    }
}

