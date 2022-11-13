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
                HStack {
//                    let _ = print(article.debugDescription)
//                    VStack {
//                        Text(article.primary_color_name!)
//                        Rectangle()
//                            .fill(Color(red: Double(article.primary_r)/255,
//                                        green: Double(article.primary_g)/255,
//                                        blue: Double(article.primary_b)/255))
//                            .frame(width: 100, height: 100)
//                            .accessibilityLabel("Swatch of color " + article.primary_color_name!)
//                    }
//                    .padding()
//                    .border(.white, width: 4)
//                    if (article.secondary_color_name! != nil){
//                        VStack {
//                            Text(article.secondary_color_name!)
//                            Rectangle()
//                                .fill(Color(red: Double(article.secondary_r)/255,
//                                            green: Double(article.secondary_g)/255,
//                                            blue: Double(article.secondary_b)/255))
//                                .frame(width: 100, height: 100)
//                        }
//                        .padding()
//                        .border(.white, width: 4)
//                    }
                }
            }
//            Spacer()
                .background(Color(red: 0.96, green: 0.94, blue: 0.91))
        }//.navigationBarBackButtonHidden(true)
    }
}

//struct ArticleView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArticleView()
//    }
//}
