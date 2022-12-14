//
//  CompArticleView.swift
//  closet-color-id
//
//  Created by Waverly Chin on 12/14/22.
//

import SwiftUI

struct CompArticleView: View {
    var article: Article
    let viewModel: ViewModel
    let backgroundColor : Color = Color(red: 141, green: 223, blue: 144)
    var comp_article: Article? {
        get {
            return self.viewModel.findComplimentaryArticle(article: self.article)
        }
    }
    var body: some View {
        ZStack{
            GeometryReader { geometry in
//                NavigationView {
                    ScrollView{
                        VStack{
                            Spacer()
                            let articleStyle = article.articleStyles?.allObjects.first as! ArticleStyle
                            Image(uiImage: UIImage(data: article.image_data!)!).resizable().scaledToFit().cornerRadius(10)
                                .accessibilityLabel("Image of article. See below for article information.").frame(width: geometry.size.width * 0.75)
                            Text("clothing tags").foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                            VStack{
                                HStack {
                                    Text(article.category!)
                                        .padding()
                                        .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                                        .border(Color(red: 0.30, green: 0.11, blue: 0.00), width: 2)
                                        .background(.white)
                                    Text(article.subcategory!)
                                        .padding()
                                        .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                                        .border(Color(red: 0.30, green: 0.11, blue: 0.00), width: 2)
                                        .background(.white)
                                    
                                }
                                Text((articleStyle.style?.name!)!)
                                    .padding()
                                    .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                                    .border(Color(red: 0.30, green: 0.11, blue: 0.00), width: 2)
                                    .background(.white)
                            }.font(.system(size: 15))
                            VStack {
                                HStack {
                                    VStack {
                                        Text(article.primary_color_name!)
                                        Rectangle()
                                            .fill(Color(red: Double(article.primary_r)/255,
                                                        green: Double(article.primary_g)/255,
                                                        blue: Double(article.primary_b)/255))
                                            .frame(width: 100, height: 100)
                                            .accessibilityLabel("Primary color")
                                    }
                                    .frame(width: geometry.size.width * 0.3)
                                    .padding()
                                    .border(.white, width: 4)
                                    let (r1, g1,b1) = viewModel.rgbColorFamily(color: article.primary_color_family!)
                                    VStack {
                                        Text(article.primary_color_family!)
                                        Rectangle()
                                            .fill(Color(red: r1, green: g1, blue: b1))
                                            .frame(width: 100, height: 100)
                                            .accessibilityLabel("Color family of primary color")
                                    }
                                    .frame(width: geometry.size.width * 0.3)
                                    .padding()
                                    .border(.white, width: 4)
                                }
                                HStack {
                                    if (article.secondary_color_name != nil) {
                                        VStack {
                                            Text(article.secondary_color_name!)
                                            Rectangle()
                                                .fill(Color(red: Double(article.secondary_r)/255,
                                                            green: Double(article.secondary_g)/255,
                                                            blue: Double(article.secondary_b)/255))
                                                .frame(width: 100, height: 100)
                                                .accessibilityLabel("Secondary color")
                                        }
                                        .frame(width: geometry.size.width * 0.3)
                                        .padding()
                                        .border(.white, width: 4)
                                        let (r2, g2, b2) = viewModel.rgbColorFamily(color: article.secondary_color_family!)
                                        VStack {
                                            Text(article.secondary_color_family!)
                                            Rectangle()
                                                .fill(Color(red: r2, green: g2, blue: b2))
                                                .frame(width: 100, height: 100)
                                                .accessibilityLabel("Color family of secondary color")
                                        }
                                        .frame(width: geometry.size.width * 0.3)
                                        .padding()
                                        .border(.white, width: 4)
                                    }
                                }
                            }
                        }
                        .frame(width: geometry.size.width)
                        .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                        .font(.system(size: 20)).bold()
                        .textCase(.uppercase)
                        .background(Color(red: 0.96, green: 0.94, blue: 0.91))
                    }
//                }
            }
        }
    }
}

//struct CompArticleView_Previews: PreviewProvider {
//    static var previews: some View {
//        CompArticleView()
//    }
//}
