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
    var body: some View {
        NavigationView {
            VStack{
                let articleStyle = article.articleStyles?.allObjects.first as! ArticleStyle
                Image(uiImage: UIImage(data: article.image_data!)!).resizable().scaledToFit().padding().rotationEffect(.degrees(90))
                    .accessibilityLabel("Image of article. See below for article information.")
                HStack {
                    Text(article.category!)
                        .padding()
                        .border(Color(red: 0.30, green: 0.11, blue: 0.00), width: 2)
                        .background(.white)
                    Text(article.subcategory!)
                        .padding()
                        .border(Color(red: 0.30, green: 0.11, blue: 0.00), width: 2)
                        .background(.white)
                    Text((articleStyle.style?.name!)!)
                        .padding()
                        .border(Color(red: 0.30, green: 0.11, blue: 0.00), width: 2)
                        .background(.white)
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
            }//.navigationBarBackButtonHidden(true)
            .background(Color(red: 0.96, green: 0.94, blue: 0.91))
        }
    }
}

