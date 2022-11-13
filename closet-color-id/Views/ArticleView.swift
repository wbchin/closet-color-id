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
    var body: some View {
        NavigationView {
            VStack{
                let articleStyle = article.articleStyles?.allObjects.first as! ArticleStyle
                Image(uiImage: UIImage(data: article.image_data!)!).resizable().scaledToFit().padding().rotationEffect(.degrees(90))
                    //.accessibilityLabel("Image of article. Categroy is " + article.category! + " subcategory is " + article.subcategory! + " style is " + articleStyle.style?.name!)
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
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .font(.system(size: 36))
            }
                .background(Color(red: 0.96, green: 0.94, blue: 0.91))
        }//.navigationBarBackButtonHidden(true)
    }
}


