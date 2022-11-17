//
//  ArticleView.swift
//  closet-color-id
//
//  Created by Waverly Chin on 11/2/22.
//

import SwiftUI
import CoreData

struct ArticleView: View {
    var article: Article
    let viewModel: ViewModel
    let backgroundColor : Color = Color(red: 141, green: 223, blue: 144)
    var comp_article: Article? {
      get {
        return self.viewModel.findComplimentaryArticle(article: self.article)
      }
    }
    var body: some View {
        NavigationView {
            VStack{
                let articleStyle = article.articleStyles?.allObjects.first as! ArticleStyle
                Image(uiImage: UIImage(data: article.image_data!)!).resizable().scaledToFit().padding().rotationEffect(.degrees(90))
                    .accessibilityLabel("Image of article. See below for article information.")
                HStack {
                    Text(article.category!)
                        .padding()
                        .border(.white, width: 4)
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
                .font(.system(size: 36))
            }
                .background(Color(red: 0.96, green: 0.94, blue: 0.91))
        }//.navigationBarBackButtonHidden(true)
    }
}


