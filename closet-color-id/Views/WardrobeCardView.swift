//
//  WardrobeCardView.swift
//  closet-color-id
//
//  Created by Waverly Chin on 11/2/22.
//

import SwiftUI

struct WardrobeCardView: View {
    let viewModel: ViewModel
    var article: Article
    var body: some View {
      Button(action: {
        self.viewModel.deleteArticle(article_id: article.objectID)
      }) {
        Text("Delete")
      }
        NavigationLink (
          destination: ArticleView(article: article, viewModel: viewModel),
            label:{
              Text(article.primary_color_family!)
              //Image(uiImage:  UIImage(data: article.image_data!)!) //This is unsafe and needs to be revised.
            })
      
        

    }
}

//struct WardrobeCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        WardrobeCardView()
//    }
//}
