//
//  WardrobeCardView.swift
//  closet-color-id
//
//  Created by Waverly Chin on 11/2/22.
//

import SwiftUI

struct WardrobeCardView: View {
    var article: Article
    var body: some View {
        NavigationLink (destination: ArticleView(article: article)){
            openImage(article: article)
        }
    }
}

func openImage(article: Article) -> Image?{
    guard let dataToImage = UIImage(data:article.imageData) ?? nil else { return nil }
    return Image(uiImage: dataToImage)
}

//struct WardrobeCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        WardrobeCardView()
//    }
//}
