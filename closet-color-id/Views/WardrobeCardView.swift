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
        NavigationLink (
            destination: ArticleView(article: article),
            label:{
                Text(article.id.uuidString)
                Image(uiImage:  UIImage(data: article.imageData.data(using: .utf8)!, scale: 1)!) //This is unsafe and needs to be revised. 
            })
        

    }
}

//struct WardrobeCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        WardrobeCardView()
//    }
//}